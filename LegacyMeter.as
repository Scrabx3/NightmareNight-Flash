import com.greensock.TimelineLite;
import com.greensock.easing.*;

import FrenzyMeter;

class LegacyMeter extends FrenzyMeter {
	
	public function LegacyMeter() {
		super();
	}

	public function updateMeterDuration(duration: Number): Void
	{
		if (_paused)
			_paused = false;

		if (!timeline.isActive())
		{
			timeline.clear();
			timeline.progress(0);
			timeline.restart();
		}
		timeline.to(MeterContainer.Mask, duration, {_x: minWidth + (_percent * 100)});
		timeline.play();
	}
}
