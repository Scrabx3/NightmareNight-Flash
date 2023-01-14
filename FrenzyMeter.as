
import com.greensock.*;
import com.greensock.easing.*;

class FrenzyMeter extends MovieClip
{
	var MeterContainer:MovieClip;
	var meterDuration:Number;
	var minWidth:Number;
	var maxWidth:Number;

	var MeterTimeline:TimelineLite;

	var _paused: Boolean;
	var _percent:Number;

	public function FrenzyMeter()
	{
		super();

		meterDuration = 0.01;
		_paused = false;

		MeterTimeline = new TimelineLite({_paused:true});
		maxWidth = MeterContainer.Mask._x;
		minWidth = MeterContainer.Mask._x - MeterContainer.Mask._width;
		_percent = (maxWidth - minWidth) / 100;
	}

	public function onLoad()
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
		if (force) {
			_alpha = 0;
			return;
		}
		TweenLite.to(this, 0.9, { _alpha: 0, ease: Quint.easeOut });
	}

	public function show(): Void
	{
		TweenLite.to(this, 0.6, { _alpha: 100, ease: Strong.easeIn });
	}

	public function pauseMeter(): Void
	{
		if (_paused)
			return;

		_paused = true;
		MeterTimeline.stop();
	}

	public function resumeMeter(): Void
	{
		if (!_paused)
			return;

		_paused = false;
		MeterTimeline.resume();
	}

	public function setMeterPercent(percent :Number):Void
	{
		MeterTimeline.clear();
		percent = Math.min(100, Math.max(percent, 0));
		MeterContainer.Mask._x = minWidth + (_percent * percent);
	}

	public function updateMeterPercent(percent: Number):Void
	{
		percent = Math.min(100, Math.max(percent, 0));

		if (!MeterTimeline.isActive())
		{
			MeterTimeline.clear();
			MeterTimeline.progress(0);
			MeterTimeline.restart();
		}
		MeterTimeline.to(MeterContainer.Mask, 1, {_x: minWidth + (_percent * percent)}, MeterTimeline.time() + meterDuration);
		MeterTimeline.play();
	}

}