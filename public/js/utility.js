function getSvgById(id_) {
  svg = d3.select(document.getElementById(id_).contentDocument);
  return svg;
}