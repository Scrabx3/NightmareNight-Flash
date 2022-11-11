import com.greensock.TimelineLite;
import com.greensock.easing.*;

class FrenzyMeter extends MovieClip
{
	var MeterContainer:MovieClip;
	var meterDuration:Number;
	var minWidth:Number;
	var maxWidth:Number;

	var timeline:TimelineLite;

	private var _hidden: Boolean;
	private var _paused: Boolean;
	private var _percent:Number;

	public function FrenzyMeter()
	{
		super();
		meterDuration = 0.01;

		timeline = new TimelineLite({_paused:true});
		maxWidth = MeterContainer.Mask._x;
		minWidth = MeterContainer.Mask._x - MeterContainer.Mask._width;
		_percent = (maxWidth - minWidth) / 100;
	}

	public function onLoad(): Void
	{
		hide(true);
	}

	public function setLocation(xpos: Number, ypos: Number, rot: Number, xscale: Number, yscale: Number): Void
	{
		this._x = xpos;
		this._y = ypos;
		this._rotation = rot;
		this._xscale = xscale;
		this._yscale = yscale;
	}

	public function hide(force: Boolean): Void
	{
		if (_hidden)
			return;

		_hidden = true;
		force ? gotoAndPlay("fadeout") : gotoAndStop("hidden");
	}

	public function show(): Void
	{
		if (!_hidden)
			return;

		gotoAndStop("show");
	}

	public function pauseMeter(): Void
	{
		timeline.stop();
	}

	public function resumeMeter(): Void
	{
		timeline.resume();
	}

	public function setMeterPercent(percent :Number, force: Boolean):Void
	{
		if (!force) {
			updateMeterPercent(percent);
		} else {
			_paused = false;
			timeline.clear();
			percent = Math.min(0, Math.max(percent, 100));
			MeterContainer.Mask._x = minWidth + (_percent * percent);
		}
	}

	private function updateMeterPercent(percent: Number):Void
	{
		if (_paused)
			return;

		percent = Math.min(0, Math.max(percent, 100));

		if (!timeline.isActive())
		{
			timeline.clear();
			timeline.progress(0);
			timeline.restart();
		}
		timeline.to(MeterContainer.Mask, 1, {_x: minWidth + (_percent * percent)}, timeline.time() + meterDuration);
		timeline.play();
	}

}