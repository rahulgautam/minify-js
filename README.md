minify-js
=========

##### minify all JavaScript files of a project at once
    Usage:
     # bash minify.sh <source_folder_for_js_files> <destination_folder_for_js_file>
    Example:
     # bash minify.sh /opt/senery/js/dev-js /opt/senery/js/pro-js

NOTE:
 - Folder/Directory path should be absolute path


 >It will recursively traverse all subfolders and js files in `source_folder_for_js_files`
 >And will create the same sub-folder structure in `destination_folder_for_js_file` if not present
 >while minifing js files.


TODO:
 - Add options for closure-compiler
 - Add python script that uses google closure rest-api.


> The [Google](http://www.google.com) Closure Compiler is a JavaScript optimizer that rewrites JavaScript code to make it faster and more compact.
