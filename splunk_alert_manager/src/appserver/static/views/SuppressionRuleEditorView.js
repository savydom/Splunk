require.config({
    paths: {
        handsontable: "../app/alert_manager/contrib/handsontable-0.12.2/handsontable.full.min",
        text: "../app/alert_manager/contrib/text",
    },
    shim: {
        handsontable: {
            deps: ['jquery']
        }
    }
});

define(['underscore', 'splunkjs/mvc', 'jquery', 'splunkjs/mvc/simplesplunkview', "handsontable", 'text!../app/alert_manager/templates/SuppressionRuleEditor.html', "css!../app/alert_manager/SuppressionRuleEditor.css"],
function(_, mvc, $, SimpleSplunkView, Handsontable, SuppressionRuleEditorTemplate) {
	
    // Define the custom view class
    var SuppressionRuleEditorView = SimpleSplunkView.extend({
        className: "SuppressionRuleEditorView",
        
        defaults: {
            'collection_owner': 'nobody',
        	'list_link': null,
        	'list_link_title': "Back to list"
        },
        
        events: {
        	"click #save": "saveSuppressionRule",
        	"click #cancel": "gotoToList"
        },
        
        initialize: function() {
        	
        	// Apply the defaults
        	this.options = _.extend({}, this.defaults, this.options);
        	
            this.list_link = this.options.list_link;
            this.list_link_title = this.options.list_link_title;
        	
        	this.lister = this.options.lister;
        	
            this.collection_owner = this.options.collection_owner;
            this.app = this.options.app;
            this.collection = this.options.collection;

        	this.suppression_rule = null;
        },
        
        hasCapability: function(capability){
        	
        	var uri = Splunk.util.make_url("/splunkd/__raw/services/authentication/current-context?output_mode=json");
        	
        	if( this.capabilities === null ){
        		
	            // Fire off the request
	            jQuery.ajax({
	            	url:     uri,
	                type:    'GET',
	                async:   false,
	                success: function(result) {
	                	
	                	if(result !== undefined){
	                		this.capabilities = result.entry[0].content.capabilities;
	                	}
	                	
	                }.bind(this)
	            });
        	}
            
            return $.inArray(capability, this.capabilities) >= 0;
        	
        },

        getSuppressionRule: function(key){
            
            var uri = Splunk.util.make_url("/splunkd/__raw/servicesNS/" + this.collection_owner + "/" + this.app + "/storage/collections/data/" + this.collection + "/" + key + "?output_mode=json");
            var suppression_rules = null;
            
            jQuery.ajax({
                url:     uri,
                type:    'GET',
                async:   false,
                success: function(results) {
                    
                    // Use the include filter function to prune items that should not be included (if necessary)
                    if( key === "" && this.include_filter !== null ){
                        suppression_rules = [];
                        
                        // Store the unfiltered list of lookups
                        this.unfiltered_suppression_rules = results;
                        
                        for( var c = 0; c < results.length; c++){
                            if( this.include_filter(results[c]) ){
                                suppression_rules.push(results[c]);
                            }
                        }
                    }
                    
                    // Just pass the lookups if no filter is necessary.
                    else{
                        suppression_rules = results;
                    }
                }.bind(this)
            });
            
            return suppression_rules;
        },
        
        render: function() {
        	
        	// Load the suppression rule
        	var key = this.getParameterByName("key");
            suppression_rule = this.getSuppressionRule(key);
            this.suppression_rule = suppression_rule;
        	
            insufficient_permissions = false;
        	
        	
        	// Render the view
        	this.$el.html( _.template(SuppressionRuleEditorTemplate,{ 
        		lister: this.lister,
        		insufficient_permissions: insufficient_permissions,
                suppression_title: suppression_rule.suppression_title,
        		list_link: this.list_link,
        		list_link_title: this.list_link_title,
        		is_new: false // TODO
        	}));
        	
        	// Start the process of loading the lookup file into the interface
        	this.loadSuppressionRule(suppression_rule);
        	
        },
               
        loadSuppressionRule: function(suppression_rule) {
            console.log("suppression_rule",suppression_rule);
            this.setupTable( suppression_rule.rules );
            $("#tableEditor").show();
            $(".table-loading-message").hide();
        },

        doSaveSuppressionRule: function() {
            var handsontable = $("#dataTable").data('handsontable');
            var row_data = handsontable.getData();

            // Make sure at least a header exists
            if(row_data.length === 0){
                $("#item-data-table > div > .widgeterror").text("You need to define at least one rule!");
                $("#item-data-table > div > .widgeterror").show();
                $("#save > span").text("Save");
                alert("You need to define at least one rule!");
                return false;
            }

            var rules = Array(); 
            _.each(row_data, function(rule){
                rules.push({ field: rule.field, condition: rule.condition, value: rule.value});
                
            });


            var new_suppression_rule = this.suppression_rule;
            new_suppression_rule.rules = rules;
                        
            var uri = Splunk.util.make_url("/splunkd/__raw/servicesNS/" + this.collection_owner + "/" + this.app + "/storage/collections/data/" + this.collection + "/" + new_suppression_rule._key + "?output_mode=json");
                        
            $.ajax({
                url: uri,
                type: 'POST',
                async: false,
                contentType: "application/json",
                data: JSON.stringify(new_suppression_rule),
                error: function(jqXHR, textStatus, errorThrown ){
                    console.log("Suppression rule not saved");
                    alert("The Suppression rule could not be saved");
                    $("#save").text("Save");
                },
                success: this.saveSuccess.bind(this),
            });

            return false;
        },


        saveSuppressionRule: function (){
            $("#save > span").text("Saving...");            
            // Use a delay so that the event loop is able to change the button text before the work begins
            setTimeout( this.doSaveSuppressionRule.bind(this), 100);
        },
        
        
        /**
         * Get the parameter with the given name.
         */
        getParameterByName: function(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            
            return results === null ? null : decodeURIComponent(results[1].replace(/\+/g, " "));
        },
        
        /**
         * Setup the table with the data.
         */
        setupTable: function ( data ){
        	
        	if (data === null){
        		data = [
        			["", "", ""],
        			["", "", ""]
        		];
        	}
        	
        	//var lookupRenderer = this.lookupRenderer;
        	var validate = this.validate;
        
        	$("#dataTable").handsontable({
        	  data: data,
        	  startRows: 1,
        	  startCols: 1,
        	  minSpareRows: 0,
        	  minSpareCols: 0,
        	  colHeaders: ["field", "condition", "value"],
              columns: [{ data: "field", type: "text"},
                        {
                            data: "condition",
                            type: "dropdown",
                            source: ["<", ">", "is", "is not", "<=", ">=", "contains", "does not contain", "starts with", "ends with"],
                        },
                        { data: "value", type: "text"},],
        	  rowHeaders: true,
        	  stretchH: 'all',
        	  manualColumnResize: true,
        	  manualColumnMove: true,
        	  fixedRowsTop: 0,
        	  onBeforeChange: validate,
        	  height: $(document).height() - 320,
        	  //contextMenu: ['row_above', 'row_below', 'remove_row', 'hsep', 'col_left', 'col_right', 'sep2', 'remove_row', 'remove_col', 'sep', 'undo', 'redo'],
        	  contextMenu: {
        		  items: {
        			  "row_above": { },
        			  "row_below": { },
        		      "hsep1": "---------",
        		      "remove_row": { },
        		      "hsep3": "---------",
        			  "undo": { },
        			  "redo": { }
        		    }
        	  },
        	  
        	  cells: function(row, col, prop) {
        		  //this.renderer = lookupRenderer;
        	  }
        	  
        	});
        },
        
        /**
         * Validate the table data.
         */
        validate: function (data) {
        	
        	// If the cell is the first row, then ensure that the new value is not blank
        	if( data[0][0] === 0 && data[0][3].length === 0 ){
        		return false;
        	}

            // Todo
            // check for empty cells
            // check field format
        },

        /**
         * Go to the lookups list.
         */
        gotoToList: function (){
        	
        	if( $('#returnto').length > 0 && $('#returnto').val() ){
        		document.location = $('#returnto').val();
        	}
        	else if( this.lister !== null && this.lister !== undefined ){
        		document.location = this.lister;
        	}
        },

        /**
         * Save succeeded.
         */
        saveSuccess: function (){
        	console.log("Suppression rule saved successfully");

        	$("#save").text("Save");
        	
        	//var messenger = Splunk.Messenger.System.getInstance();
        	//messenger.send('info', "splunk.sa_utils", "File successfully updated");
        	
        	// Return the user to the suppression list
        	this.gotoToList();
        },

        /**
         * Set the table dimensions such that it fills the page.
         */
        setTableDimensions: function (){
    		// Set the data-table width and height so that the editor takes up the entire page
    		// We shouldn't have to do this since we should be able to use width of 100%. However, width 100% only works if
    		// the parents have widths defined all the way to the top (which they don't).
    		$('#dataTable').width( $(document).width() - 100 ) ;
    		$('#dataTable').height( $(document).height() - 320 ) ;
        }

    });
     
    
    return SuppressionRuleEditorView;
});
