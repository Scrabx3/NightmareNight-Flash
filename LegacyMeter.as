﻿import com.greensock.TimelineLite;
import com.greensock.easing.*;
import skse;

import FrenzyMeter;

class LegacyMeter extends FrenzyMeter 
{
	public function LegacyMeter() {
		super();
	}

	public function onLoad()
	{
		super.onLoad();

		setLocation(0.50, 0.96);
	}

	public function forceMeterPercent(percent :Number):Void
	{
		MeterTimeline.clear();
		percent = Math.min(100, Math.max(percent, 0));
		MeterContainer.Mask._x = minWidth + (_percent * percent);
	}

	public function updateMeterDuration(duration: Number): Void
	{
		forceMeterPercent(100);

		if (!MeterTimeline.isActive())
		{
			MeterTimeline.clear();
			MeterTimeline.progress(0);
			MeterTimeline.restart();
		}
		
		MeterTimeline.to(MeterContainer.Mask, duration, {_x: minWidth, onComplete: onComplete, onCompleteParams:[this]}, MeterTimeline.time() + meterDuration);
		MeterTimeline.play();
	}

	public function onComplete(a_this: MovieClip)
	{
		a_this.hide(false);
		skse.SendModEvent("NightmareNightFrenzyEnd");
	}

}
