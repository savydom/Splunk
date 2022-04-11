[settings]
	* If you do not specify an entry for each attribute, the event manager will use the default value.

index	= <index_name>
	* Name of the index where the alert meta events will be written to
	* Defaults to "main"

incident_list_length = <integer>
	* Number of events shown in list in the incident posture dashboard
	* Defaults to 10

default_owner = <owner_name>
	* Default owner for new alerts
	* Defaults to "unassigned"

default_impact = <impact_name>
        * Fallback impact for new incidents if the alert handler is unable to parse it
        * Defaults to "low"

default_urgency = <urgency_name>
        * Fallback urgency for new incidents if the alert handler is unable to parse it from results
        * Defaults to "low"

default_priority = <priority_name>
        * Fallback priority for new incidents if the alert handler is unable to parse it
        * Defaults to "low"

user_directories = [both | builtin | alert_manager]
	* Configure which user directories are enabled
	* Defaults to both

collect_data_results = [true | false]
	* Configure if alert results are written to KVStore
	* Defaults to true

index_data_results = [true | false]
	* Configure if alert results are indexed back into Splunk
	* Defaults to false

auto_close_info = [true | false]
	* Configure if informational events are automatically resolved
	* Defaults to false

auto_close_info_status = <status_code>
	* Status to assign for automatically closed informational events
	* Defaults to auto_info_resolved

append_ignore_status = <regex>
	* Don't append incidents to status that match the regex
	* Defaults to resolved

[logging]
rootLevel = [DEBUG | INFO | WARN | ERROR | CRITICAL]
	* Root log level
	* Defaults to INFO

logger.alert_manager = [DEBUG | INFO | WARN | ERROR | CRITICAL]
	* Log level for main alert action
	* Defaults to INFO

logger.alert_manager_scheduler = [DEBUG | INFO | WARN | ERROR | CRITICAL]
	* Log level for scheduler component
	* Defaults to INFO

logger.alert_manager_controllers = [DEBUG | INFO | WARN | ERROR | CRITICAL]
	* Log level for splunkd endpoints
	* Defaults to INFO

logger.alert_manager_eventhandler = [DEBUG | INFO | WARN | ERROR | CRITICAL]
	* Log level for eventhandler (internal component)
	* Defaults to INFO

logger.alert_manager_notifications = [DEBUG | INFO | WARN | ERROR | CRITICAL]
	* Log level for e-mail notifications
	* Defaults to INFO

logger.alert_manager_suppression_helper = [DEBUG | INFO | WARN | ERROR | CRITICAL]
	* Log level for suppression subsystem (part of alert action)
	* Defaults to INFO

logger.alert_manager_rest_handler = [DEBUG | INFO | WARN | ERROR | CRITICAL]
	* Log level for REST handlers
	* Defaults to INFO

logger.alert_manager_csvlookup = [DEBUG | INFO | WARN | ERROR | CRITICAL]
    * Log level for csvlookup component
    * Defaults to INFO

logger.alert_manager_migration = [DEBUG | INFO | WARN | ERROR | CRITICAL]
    * Log level for migration scripts
    * Defaults to INFO