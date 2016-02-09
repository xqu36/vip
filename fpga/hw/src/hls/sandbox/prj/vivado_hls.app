<AutoPilot:project xmlns:AutoPilot="com.autoesl.autopilot.project" projectType="C/C++" name="prj" top="sandbox">
    <Simulation argv="">
        <SimFlow name="csim" setup="false" optimizeCompile="true" clean="false" ldflags="" mflags="-j4"/>
    </Simulation>
    <includePaths/>
    <libraryFlag/>
    <files>
        <file name="../../../common/images/test_1080p.bmp" sc="0" tb="1" cflags=" "/>
        <file name="../../hls_sandbox.cpp" sc="0" tb="1" cflags=" "/>
        <file name="../../opencv_sandbox.cpp" sc="0" tb="1" cflags=" "/>
        <file name="../../test.cpp" sc="0" tb="1" cflags=" "/>
        <file name="top.cpp" sc="0" tb="false" cflags=""/>
    </files>
    <solutions>
        <solution name="solution1" status=""/>
    </solutions>
</AutoPilot:project>

