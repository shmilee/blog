#!/usr/bin/bash

hexo_plugins=('hexo-generator-feed'
              'hexo-generator-sitemap'
              'hexo-generator-minify'
              'hexo-local-image'
              'hexo-tag-emojis'
              'hexo-math'
              'hexo-tag-bootstrap'
              'hexo-broken-link-checker')
usage() {
    cat <<EOF
usage: $0 [ install | uninstall | update ]
EOF
}

if [ ! -f _config.yml ]; then
    echo "Please run me in a Hexo-site folder."
    exit 1
fi
case $1 in
    install)
        for plugin in ${hexo_plugins[@]}; do
            if [ ! -d node_modules/$plugin ]; then
                npm install $plugin --save
            fi
        done
        ;;
    uninstall)
        for plugin in ${hexo_plugins[@]}; do
            if [ -d node_modules/$plugin ]; then
                npm uninstall $plugin
            fi
        done
        ;;
    update)
        npm update
        ;;
    *)
        usage
        ;;
esac
exit 0
