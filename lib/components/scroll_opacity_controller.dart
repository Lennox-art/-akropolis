import 'package:akropolis/main.dart';
import 'package:flutter/widgets.dart';

class ScrollOpacityController {
  final String debugName;
  final ScrollController scrollController;
  final void Function(double opacity) onScroll;

  bool isScrollingDown = true;
  double _previousOffset = 0.0;
  double _previousOffsetSinceChangeInDirection = 0.0;

  double get threshold => 300.0;

  double get maxOpacity => 1.0;

  double get minOpacity => 0.3;

  ScrollOpacityController({
    required this.scrollController,
    required this.debugName,
    required this.onScroll,
  }) {
    scrollController.addListener(_handleScroll);
    log.debug("Attached to $debugName");
  }

  void _handleScroll() {
    double offset = scrollController.offset;

    double changeSinceLastScroll = offset - _previousOffset;
    double dy = (offset - _previousOffsetSinceChangeInDirection).abs();

    bool isNewScrollingDown = changeSinceLastScroll > 0;
    bool hasChangedDirection = isNewScrollingDown != isScrollingDown;

    log.debug(
      """$debugName ==> Offset $offset, dy $dy, changeSinceLastScroll $changeSinceLastScroll,
      isScrollingDown $isScrollingDown, hasChangedDirection $hasChangedDirection
      _previousOffsetSinceChangeInDirection = $_previousOffsetSinceChangeInDirection
      """,
    );

    //If has changed direction
    if (hasChangedDirection) {
      _previousOffsetSinceChangeInDirection = offset;
    }

    if (offset <= threshold) {
      // At the top, opacity should be fully visible
      _updateOpacity(maxOpacity);
    } else if (!hasChangedDirection && isScrollingDown && dy > threshold) {
      // Scrolling down past 300 pixels
      _updateOpacity(minOpacity);
    } else if (!hasChangedDirection && !isScrollingDown && dy > threshold) {
      // Scrolling up past 300 pixels
      _updateOpacity(maxOpacity);
    }

    _previousOffset = offset;
    isScrollingDown = isNewScrollingDown;
  }

  void _updateOpacity(double newOpacity) {
    onScroll(newOpacity);
  }

  void dispose() {
    scrollController.removeListener(_handleScroll);
  }
}
