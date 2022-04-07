import os

# Check if $SPLUNK_HOME is set. None of this script will work if it's not.
try:
    splunk_home = os.environ['SPLUNK_HOME']
except Exception as exception:
    print('$SPLUNK_HOME is not set. Please set it and try again. Exception {}'.format(exception))
    exit()

root_directory = splunk_home + '/share/splunk/search_mrsparkle/' # root directory should be an absolute path starting from '/'
files_to_delete = [
    'exposed/js/build/simplexml/config.js',
    'exposed/js/build/simplexml.min/config.js',
    'exposed/js/contrib/jquery/jquery.js',
    'exposed/js/contrib/jquery-1.8.2.js',
    'exposed/js/contrib/jquery-1.8.2.min.js',
    'exposed/js/contrib/jquery-2.1.0.js',
    'exposed/js/contrib/jquery-2.1.0.min.js',
    'exposed/build/single_value/index.js',
    'exposed/build/pages/enterprise/dashboard.js',
    'exposed/build/pages/lite/dashboard.js',
    'exposed/build/pages/dark/dashboard.js',
    'exposed/build/pdf_mapping/index.js',
    'exposed/build/simplexml/index.js',
    'exposed/build/jscharting/index.js',
    'templates/pages/dashboard.html'
]

for filename in files_to_delete:
    file_path = os.path.join(root_directory, filename)
    try:
        if os.path.isfile(file_path) or os.path.islink(file_path):
            if not os.access(file_path, os.W_OK): # if there is no sufficient permissions, set it.
                os.chmod(file_path, 0o777)  # python 3.7 syntax
            else:
                print('Could not set permissions for file {}'.format(file_path))
                continue
            os.remove(file_path)
            print('Successfully removed file {}'.format(file_path))
        else:
            print('File {} not found. Unable to delete.'.format(file_path))
    except Exception as e:
        print('Failed to delete {}. Reason: {}'.format(file_path, e))
