#! /bin/bash
set -xv
set -eu

zip=/tmp/xsh-$$.zip

until [[ -d .git ]] ; do cd .. ; done

git checkout master
git status --porcelain | grep ^ && exit 1
(
    cd xsh
    perl Makefile.PL
    make docs
    cd doc
    rm -rf "$zip"
    zip -mr "$zip" .
)
git checkout gh-pages
git clean -df
unzip -o "$zip"
rm "$zip"

xmllint --c14n xsh_reference.xml > xsh_reference.xml2
mv xsh_reference.xml{2,}
xsh <<EOF
for {qw( xsh.html XSH2.html )} {
    open :F html (.) ;
    for //a[starts-with(@href, '/') or not(@href)]
        set @href concat('https://p3rl.org/', text()) ;
    save :F html ;
}
EOF

git add .
git commit -m "Generate documentation on $(date)"
echo git push origin gh-pages
