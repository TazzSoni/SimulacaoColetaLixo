globals [

  intersections
  roads
  spawned-cars1
  spawned-cars2
  spawned-cars3
  spawned-cars4
  spawned-cars5
  spawned-cars6
  spawned-cars7
  spawned-cars8
  spawned-cars9
  spawned-trucks
  time-start
  time-finish
  time-stoped
  stop-condition?
  time
  truck-died?
]

breed [ lights light ]


breed [ cars car ]
breed [ carrs carr ]
breed [trucks truck]

cars-own [
  speed
]
carrs-own [
  speed
]
trucks-own [
  speed
]

patches-own
[
  intersection?
]

to setup
  clear-all
  set-default-shape lights "square"
  set-default-shape cars "car"
  set-default-shape carrs "car"
  set-default-shape trucks "truck"
  set truck-died? false
  ask patches
  [
    set intersection? false
    set pcolor green
  ]

  set roads patches with
    [(floor((pxcor + max-pxcor - floor(10 - 1)) mod 10) = 0) or
    (floor((pycor + max-pycor) mod 10) = 0)]
  set intersections roads with
    [(floor((pxcor + max-pxcor - floor(10 - 1)) mod 10) = 0) and
    (floor((pycor + max-pycor) mod 10) = 0)]

  ask roads [ set pcolor black ]
  ask intersections [ set pcolor pink


  ]

  reset-ticks
end

to go

  ask cars [ move1 ]
  ask carrs [ move2 ]
  ask trucks [move-truck]

  make-new-car2 100 -8 -17 0
  make-new-car3 100 2 13 180
  make-new-car4 100 12 13 180
  make-new-car5 100 12 3 270
  make-new-car6 100 2 3 270
  make-new-car7 100 -8 -7 90
  make-new-car8 100 12 -17 270
  make-new-truck 60 -8 13 90

  if truck-died? [ stop ]
  set time ticks

  tick
end

to make-new-truck [ freq x y h ]

  if (random-float 100 < freq) and not any? turtles-on patch x y and spawned-trucks < 1 and time-to-go = time[

    create-trucks 1 [
      set time-start ticks

      setxy x y
      set heading h
      set color white
      set spawned-trucks spawned-trucks + 1
      adjust-speed
    ]
  ]
end

to make-new-car1 [ freq x y h ]

  if (random-float 100 < freq) and not any? turtles-on patch x y and spawned-cars1 < 50 and time > 15 [
    create-cars 1 [
      setxy x y
      set heading h
      set color one-of base-colors
      set spawned-cars1 spawned-cars1 + 1
      adjust-speed
    ]
  ]
end

to make-new-car2 [ freq x y h ]
  if (random-float 100 < freq) and not any? turtles-on patch x y and spawned-cars2 < 70 and time > 75 [
    create-cars 1 [
      setxy x y
      set heading h
      set color one-of base-colors
      set spawned-cars2 spawned-cars2 + 1
      show spawned-cars2
      adjust-speed
    ]
  ]
end

to make-new-car3 [ freq x y h ]
  if (random-float 100 < freq) and not any? turtles-on patch x y and spawned-cars3 < 75 and time > 15[
    create-carrs 1 [
      setxy x y
      set heading h
      set color one-of base-colors
      set spawned-cars3 spawned-cars3 + 1
      adjust-speed
    ]
  ]
end

to make-new-car4 [ freq x y h ]
  if (random-float 100 < freq) and not any? turtles-on patch x y and spawned-cars4 < 80 and time > 75[
    create-cars 1 [
      setxy x y
      set heading h
      set color one-of base-colors
      set spawned-cars4 spawned-cars4 + 1
      adjust-speed
    ]
  ]
end

to make-new-car5 [ freq x y h ]
  if (random-float 100 < freq) and not any? turtles-on patch x y and spawned-cars5 < 80 and time > 15[
    create-cars 1 [
      setxy x y
      set heading h
      set color one-of base-colors
      set spawned-cars5 spawned-cars5 + 1
      adjust-speed
    ]
  ]
end

to make-new-car6 [ freq x y h ]
  if (random-float 100 < freq) and not any? turtles-on patch x y and spawned-cars6 < 60 and time > 15[
    create-cars 1 [
      setxy x y
      set heading h
      set color one-of base-colors
      set spawned-cars6 spawned-cars6 + 1
      adjust-speed
    ]
  ]
end

to make-new-car7 [ freq x y h ]
  if (random-float 100 < freq) and not any? turtles-on patch x y and spawned-cars7 < 50 and time > 150 [
    create-cars 1 [
      setxy x y
      set heading h
      set color one-of base-colors
      set spawned-cars7 spawned-cars7 + 1
      adjust-speed
    ]
  ]
end

to make-new-car8 [ freq x y h ]
  if (random-float 100 < freq) and not any? turtles-on patch x y and spawned-cars8 < 90 and time > 150  [
    create-cars 1 [
      setxy x y
      set heading h
      set color one-of base-colors
      set spawned-cars8 spawned-cars8 + 1
      adjust-speed
    ]
  ]
end

to move1
  adjust-speed
  repeat speed [
    fd 1
    if not can-move? 1 [ die]
    if [pxcor] of patch-ahead 1 = 14 [die]
  ]
end

to move2
  adjust-speed
  repeat speed [
    fd 1
    if not can-move? 1 [ die]
    if [pxcor] of patch-ahead 1 = -17 [die]
  ]
end

to move-truck
 if speed = 0 [set time-stoped time-stoped + 1]
  adjust-speed
 repeat speed [
    if not can-move? 1 [ die ]
    ifelse [pxcor] of patch-here = 12 and [pycor] of patch-here = 13[

     ask trucks [
      face patch 12 3
        fd 0.1
      ]
    ]
    [fd 0.1]

    ifelse [pxcor] of patch-here = 12 and [pycor] of patch-here = 3[
     ask trucks [
      face patch 2 3
        fd 0.1
      ]
    ]
    [fd 0.1]
        ifelse [pxcor] of patch-here = 2 and [pycor] of patch-here = 3[
     ask trucks [
      face patch 2 -7
        fd 0.1
      ]
    ]
    [fd 0.1]
        ifelse [pxcor] of patch-here = 2 and [pycor] of patch-here = -7[
      ask trucks [
      face patch 12 -7
        fd 0.1
      ]
    ]
    [fd 0.1]
        ifelse [pxcor] of patch-here = 12 and [pycor] of patch-here = -7[
     ask trucks [
      face patch 12 -17
        fd 0.1
      ]
    ]
    [fd 0.1]
        ifelse [pxcor] of patch-here = 12 and [pycor] of patch-here = -17[
     ask trucks [
      face patch -8 -17
        fd 0.1
      ]
    ]
    [fd 0.1]
        ifelse [pxcor] of patch-here = -8 and [pycor] of patch-here = -17[
     ask trucks [
      face patch -8 13
        fd 0.1
      ]
    ]
    [fd 0.1]
    if [pxcor] of patch-here = -8 and [pycor] of patch-here = 13[

      set time-finish ticks

      set truck-died? true
    ]

  ]
end

to adjust-speed

  ; Calcula o mínimo e máximo de speed
  let min-speed max (list (speed - 4) 0)
  let max-speed min (list (speed + 2) 5)

  ; Sett para ir o mais rápido possível
  let target-speed max-speed

  let blocked-patch next-blocked-patch
  if blocked-patch != nobody [
    ; Caso tenha obstáculo, reduz o speed
    ; até que não tenha mais nada
    let space-ahead (distance blocked-patch - 1)
    while [
      breaking-distance-at target-speed > space-ahead and
      target-speed > min-speed
    ] [
      set target-speed (target-speed - 1)
    ]
  ]

  set speed target-speed

end

to-report breaking-distance-at [ speed-at-this-tick ]

  ; Caso freie no próximo tick, calcula a distância
  let min-speed-at-next-tick max (list (speed-at-this-tick - 4) 0)
  report speed-at-this-tick + min-speed-at-next-tick
end

to-report next-blocked-patch

  ; Verifica todos os patchs a frente até encontrar um bloqueado
  let patch-to-check patch-ahead 1
  while [ patch-to-check != nobody and not is-blocked? patch-to-check ] [
    set patch-to-check patch-ahead ((distance patch-to-check) + 1)
  ]

  ; Reporta o patch bloqueado ou nada caso não esteja
  report patch-to-check
end

to-report is-blocked? [ target-patch ]
  report
    any? other cars-on target-patch or
  any? other trucks-on target-patch
end



to-report show-time-start
  report time-start
end

to-report show-time-finish
  report time-finish
end

to-report show-time-stoped
  report time-stoped
end
@#$#@#$#@
GRAPHICS-WINDOW
175
10
568
404
-1
-1
11.0
1
10
1
1
1
0
0
0
1
-17
17
-17
17
1
1
1
ticks
30.0

BUTTON
8
10
98
43
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
105
10
170
43
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
105
45
170
78
go once
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

MONITOR
12
191
114
236
Total Time
(time-finish - time-start) / 15
17
1
11

MONITOR
14
95
100
140
Partida
show-time-start
17
1
11

MONITOR
13
142
117
187
Chegada
show-time-finish
17
1
11

MONITOR
13
253
106
298
Tempo Parado
show-time-stoped / 15
17
1
11

INPUTBOX
610
171
765
231
time-to-go
75.0
1
0
Number

TEXTBOX
610
72
796
142
Tempo de trabalho 08:00 às 17:00\n15 ticks = 1 hora\n15º tick = 07:00\n75º tick = 12:00\n150º tick = 17:00
11
0.0
1

@#$#@#$#@
## O QUE É ISSO?

Esta é uma simulação de coleta de lixo, onde temos a representação de um bairro com 12 vertices, onde nele 8 pares de partida/destino distintos disparam um número específicos de veículos cada e nosso alvo, o caminhão de coleta de lixo, percorre seu caminho passando por todos os vértices até voltar para seu vértice de origem. O usuário pode definir qual horário será a saída do caminhão de coleta e após o final da simulação, são mostrados valores de Tempo total do percurso e tempo parado. A simulação ocorre entre os ticks 0 e 150, sendo cada hora equivalente a 15 ticks e o tick 0 representando 06:00.

## COMO FUNCIONA?

As regras dos carros são:
- Parar por carros a sua frente;
- Reduzir a velocidade, caso veja que tenha tráfico a frente;
- Caso haja espaço livre a frente, andar o mais rápido possível;


## USO DA APLICAÇÃO

time-to-go -> Define o momento da partida do caminhão de lixo, cada 15 ticks equivalem a uma hora, sendo o tick 0 igual a 06:00.
Ex.: time-to-go = 15, o caminhão sairá no tick 15 que é equivalente às 07:00.

Total Time -> Recebe a contagem de ticks referente ao tempo total que o caminhão levou para percorrer o percurso e converte em valor de horas.

Tempo Parado -> Recebe a contagem de ticks referente ao tempo total que o caminhão ficou parado durante o percurso e converte em valor de horas.


## MODELOS RELACIONADOS

- "Traffic Basic": a simple model of the movement of cars on a highway.

- "Traffic Basic Utility": a version of "Traffic Basic" including a utility function for the cars.

- "Traffic Basic Adaptive": a version of "Traffic Basic" where cars adapt their acceleration to try and maintain a smooth flow of traffic.

- "Traffic Basic Adaptive Individuals": a version of "Traffic Basic Adaptive" where each car adapts individually, instead of all cars adapting in unison.

- "Traffic 2 Lanes": a more sophisticated two-lane version of the "Traffic Basic" model.

- "Traffic Grid": a model of traffic moving in a city grid, with stoplights at the intersections.

- "Traffic Grid Goal": a version of "Traffic Grid" where the cars have goals, namely to drive to and from work.

- "Gridlock HubNet": a version of "Traffic Grid" where students control traffic lights in real-time.

- "Gridlock Alternate HubNet": a version of "Gridlock HubNet" where students can enter NetLogo code to plot custom metrics.



<!--2022 -->
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
true
0
Polygon -7500403 true true 180 15 164 21 144 39 135 60 132 74 106 87 84 97 63 115 50 141 50 165 60 225 150 285 165 285 225 285 225 15 180 15
Circle -16777216 true false 180 30 90
Circle -16777216 true false 180 180 90
Polygon -16777216 true false 80 138 78 168 135 166 135 91 105 106 96 111 89 120
Circle -7500403 true true 195 195 58
Circle -7500403 true true 195 47 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fire
false
0
Polygon -7500403 true true 151 286 134 282 103 282 59 248 40 210 32 157 37 108 68 146 71 109 83 72 111 27 127 55 148 11 167 41 180 112 195 57 217 91 226 126 227 203 256 156 256 201 238 263 213 278 183 281
Polygon -955883 true false 126 284 91 251 85 212 91 168 103 132 118 153 125 181 135 141 151 96 185 161 195 203 193 253 164 286
Polygon -2674135 true false 155 284 172 268 172 243 162 224 148 201 130 233 131 260 135 282

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
