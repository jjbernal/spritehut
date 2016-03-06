Sprite Hut File Format Specification
==
Version 0.1 - Draft
--
**Latest update:** March, 6th 2016

Overview
--

Relaxed NG definition
--

Example
--
    <project width=32 height=32 colorMode="indexed">
        <meta spriteHutVersion="0.1" />
        <meta author="Juan José Bernal" />
        <meta zoomLevel="200%"/>
        <palette name="default">
            <color name="Transparent" RGBA="#00000000" />
            <color name="Red" RGBA="#ff0000ff" />
        </palette>
        <layer id=1 name="Head" visible="true" locked="false"/>
        <layer id=2 name="Body" visible="true" locked="false"/>
        <layer id=3 name="Legs" visible="true" locked="false" selected="true" />
        <animations>
            <animation name="Run" fps=12 selected="true">
                <frame position=1 timeUnit="frame">
                    <cel layerId=1 src="/data/Run/Head1.png"/>
                    <cel layerId=2 src="/data/Run/Body1.png"/>
                    <cel layerId=3 src="/data/Run/Legs1.png"/>
                </frame>
                <frame position=2 timeUnit="frame" timelineMarker=true >
                    <cel layerId=1 src="/data/Run/Head2.png"/>
                    <cel layerId=2 src="/data/Run/Body2.png"/>
                    <cel layerId=3 src="/data/Run/Legs2.png"/>
                </frame>
                <frame position=3 timeUnit="frame">
                    <cel layerId=1 src="/data/Run/Head3.png"/>
                    <cel layerId=2 src="/data/Run/Body3.png"/>
                    <cel layerId=3 src="/data/Run/Legs3.png"/>
                </frame>
            </animation>
            <animation name="Jump" fps=12>
                <frame position=1 timeUnit="frame">
                    <cel layerId=1 src="/data/Jump/Head1.png"/>
                    <cel layerId=2 src="/data/Jump/Body1.png"/>
                    <cel layerId=3 src="/data/Jump/Legs1.png"/>
                </frame>
                <frame position=2 timeUnit="frame">
                    <cel layerId=1 src="/data/Jump/Head2.png"/>
                    <cel layerId=2 src="/data/Jump/Body2.png"/>
                    <cel layerId=3 src="/data/Jump/Legs2.png"/>
                </frame>
                <frame position=3 timeUnit="frame">
                    <cel layerId=1 src="/data/Jump/Head3.png"/>
                    <cel layerId=2 src="/data/Jump/Body3.png"/>
                    <cel layerId=3 src="/data/Jump/Legs3.png"/>
                </frame>
            </animation>
        </animations>
    </project>
