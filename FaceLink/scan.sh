if [ -e  report ] ;then
rm -r report;
fi
mkdir report

/data/checker-263/scan-build  xcodebuild -target dailybuildipa -configuration DailyBuild clean -sdk iphoneos4.2
/data/checker-263/scan-build -o report xcodebuild -target dailybuildipa -configuration DailyBuild -sdk iphoneos4.2

