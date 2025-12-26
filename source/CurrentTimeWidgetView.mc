import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class CurrentTimeWidgetGlanceView extends WatchUi.GlanceView {

    private var _timer as Timer.Timer?;

    function initialize() {
        GlanceView.initialize();
        
        // Start a timer to update every second
        _timer = new Timer.Timer();
        _timer.start(method(:onTimer), 1000, true);
    }

    // Timer callback to request view update
    function onTimer() as Void {
        WatchUi.requestUpdate();
    }

    // Update the glance view
    function onUpdate(dc as Dc) as Void {
        // Get the current time
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        var minutes = clockTime.min;
        var seconds = clockTime.sec;
        
        // Format time as HH:MM:SS
        var timeString = Lang.format("$1$:$2$:$3$", [
            hours.format("%02d"),
            minutes.format("%02d"),
            seconds.format("%02d")
        ]);
        
        // Clear the screen
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Draw the time
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() / 2,
            Graphics.FONT_MEDIUM,
            timeString,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

}

class CurrentTimeWidgetView extends WatchUi.View {

    private var _timer as Timer.Timer?;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        // Start a timer to update every second
        _timer = new Timer.Timer();
        _timer.start(method(:onTimer), 1000, true);
    }

    // Timer callback to request view update
    function onTimer() as Void {
        WatchUi.requestUpdate();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        // Get the current time
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        var minutes = clockTime.min;
        var seconds = clockTime.sec;
        
        // Format time as HH:MM:SS
        var timeString = Lang.format("$1$:$2$:$3$", [
            hours.format("%02d"),
            minutes.format("%02d"),
            seconds.format("%02d")
        ]);
        
        // Get screen dimensions
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        // Set text properties
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            width / 2,
            height / 2,
            Graphics.FONT_LARGE,
            timeString,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        // Stop and clean up the timer
        if (_timer != null) {
            _timer.stop();
            _timer = null;
        }
    }

}
