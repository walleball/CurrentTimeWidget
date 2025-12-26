import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class CurrentTimeWidgetApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new CurrentTimeWidgetView() ];
    }

    // Return the glance view for the widget loop
    function getGlanceView() as [GlanceView] or [GlanceView, GlanceViewDelegate] or Null {
        return [ new CurrentTimeWidgetGlanceView() ];
    }

}

function getApp() as CurrentTimeWidgetApp {
    return Application.getApp() as CurrentTimeWidgetApp;
}