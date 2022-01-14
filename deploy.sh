#!/bin/sh

temp_dir=$(mktemp -d -t hugo-XXXXXXXXXX)

# mailchimp only checks the page at the base url for the verification script.
# Though in my case, it's merely a minimalistic redirect page to the /de subpage.
# Hack the <script> tag in here with sed and echo
# Then deploy the generated files to the server
# finally, remove the temp dir again with all files
hugo -d $temp_dir && \
    cd $temp_dir && \
    sed -e 's/<\/head>.*$//' index.html -i && \
    echo -n '<script id="mcjs">!function(c,h,i,m,p){m=c.createElement(h),p=c.getElementsByTagName(h)[0],m.async=1,m.src=i,p.parentNode.insertBefore(m,p)}(document,"script","https://chimpstatic.com/mcjs-connected/js/users/cc3ae0209e53103da8a42a18d/9c35eb59cd6e2ae72b8ea6420.js");</script></head></html>' >> index.html && \
    rsync -avz --delete $temp_dir/ alarm:/srv/http/tinotech.tips

rm -rf $temp_dir
