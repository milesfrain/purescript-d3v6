/*
Snippets from:
https://observablehq.com/@d3/selection-join

Alternate resource:
https://observablehq.com/@d3/learn-d3-joins
*/

"use strict";

function randomLetters() {
  return d3.shuffle("abcdefghijklmnopqrstuvwxyz".split(""))
    .slice(0, Math.floor(6 + Math.random() * 20))
    .sort();
}

exports.chartFFI = element => width => height => {

  const svg =
    d3.selectAll(element)
      .append("svg")
      .attr("viewBox", [0, -20, width, 33]);

  svg.selectAll("text")
    .data(randomLetters())
    .join("text")
      .attr("x", (d, i) => i * 16)
      .text(d => d);
}

/*
const svg = d3.create("svg")
  .attr("width", width)
  .attr("height", 33)
  .attr("viewBox", `0 -20 ${width} 33`);
*/

/*
while (true) {
const t = svg.transition()
  .duration(750);

svg.selectAll("text")
.data(randomLetters(), d => d)
.join(
  enter => enter.append("text")
      .attr("fill", "green")
      .attr("x", (d, i) => i * 16)
      .attr("y", -30)
      .text(d => d)
    .call(enter => enter.transition(t)
      .attr("y", 0)),
  update => update.append("text")
      .attr("fill", "black")
      .attr("y", 0)
    .call(update => update.transition(t)
      .attr("x", (d, i) => i * 16)),
  exit => exit
      .attr("fill", "brown")
    .call(exit => exit.transition(t)
      .attr("y", 30)
      .remove())
);
*/
