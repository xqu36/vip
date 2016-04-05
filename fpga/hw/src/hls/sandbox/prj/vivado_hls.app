<project xmlns="com.autoesl.autopilot.project" name="prj" top="sandbox">
    <files>
        <file name="../../../common/images/test_1080p.bmp" sc="0" tb="1" cflags=" "/>
        <file name="../../hls_sandbox.cpp" sc="0" tb="1" cflags=" "/>
        <file name="../../opencv_sandbox.cpp" sc="0" tb="1" cflags=" "/>
        <file name="../../test.cpp" sc="0" tb="1" cflags=" "/>
        <file name="top.cpp" sc="0" tb="false" cflags=""/>
    </files>
    <includePaths/>
    <libraryPaths/>
    <libraryFlag/>
    <Simulation argv="">
        <SimFlow name="csim" optimizeCompile="true" ldflags="" mflags="-j4"/>
    </Simulation>
    <solutions xmlns="">
        <solution name="solution1" status="active"/>
    </solutions>
</project>

