echo ===========================================
echo Deploying docker-maven-plugin documentation
echo ===========================================

cd doc/manual && \
npm install -g gitbook-cli && \
mkdir -p _book && \
gitbook -v 2.1.0 install .  && \
gitbook -v 2.1.0 build . && \
git clone -b gh-pages git@github.com:fabric8io/docker-maven-plugin.git gh-pages && \
cp -rv _book/* gh-pages/ && \
cd gh-pages && \
git add --ignore-errors * && \
git commit -m "generated documentation" && \
git push origin gh-pages && \
cd .. && \
rm -rf gh-pages _book node-modules
       
