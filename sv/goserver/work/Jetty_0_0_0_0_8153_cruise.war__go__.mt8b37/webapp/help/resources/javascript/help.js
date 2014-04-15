function isCollapsed(heading_element) {
  return heading_element.hasClassName('collapsed-heading');
}

function toggleCollapse(heading_element, placeholder) {
	if (isCollapsed(heading_element)) {
		heading_element.removeClassName('collapsed-heading');
		heading_element.addClassName('collapsible-heading');
		heading_element.nextSiblings()[0].removeClassName('collapsed');
	} else {
		heading_element.removeClassName('collapsible-heading');
		heading_element.addClassName('collapsed-heading');
		heading_element.nextSiblings()[0].addClassName('collapsed');
	}
}

function openFromUrl() {
  var url = window.location.href;
  if (url.lastIndexOf('#') > -1) {
    var sectionName = url.substring(url.lastIndexOf('#') + 1, url.length);
    var heading_element = $(sectionName);
    if (isCollapsed(heading_element)) {
      toggleCollapse(heading_element);
    }
  }
}

Event.observe(window, 'load',
  function () { openFromUrl(); }
);
