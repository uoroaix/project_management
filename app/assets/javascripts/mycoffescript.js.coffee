$ ->
  $(".button1").on "click", ->
    $(@).toggleClass("btn-primary").toggleClass("btn-danger")


  $(".button2").on "click", ->
    $(@).animate({width: "+=50", fontSize: "+=9"})


  $(".box").on "keyup", ->
    $array = $(@).val().split(" ")
    $cap_array = $array.map (x) -> x[0].toUpperCase() + x.slice(1) if x
    $(".boxResult").text($cap_array.join(" "))


  colors = []
  index = 0
  changeColor = ->
    $("body").css("background-color", colors[index])
    index = if index >= (colors.length-1) then 0 else (index + 1)


  $(".color-box").on "keyup", (event)->
    if event.keyCode == 13
      colors.push $(@).val()
      $(@).val("")
      $(".boxColor").text("Color Queue: " + colors.join(" "))


  setInterval(changeColor, 500)