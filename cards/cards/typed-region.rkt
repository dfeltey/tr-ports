#lang typed/racket
(require (prefix-in mred: typed/racket/gui))
(require/typed/provide "region.rkt"
                       [#:opaque Region region?]
                       [region-x (Region -> Real)]
                       [region-y (Region -> Real)]
                       [region-w (Region -> Nonnegative-Real)]
                       [region-h (Region -> Nonnegative-Real)]
                       [set-region-hilite?! (Region Boolean -> Void)]
                       [region-paint-callback (Region -> ((Instance mred:DC<%>) Real Real Real Real -> Any))]
                       [region-label (Region -> (Option (U String (Instance mred:Bitmap%))))] ; No idea if this is correct or not?
                       [region-button? (Region -> Boolean)]
                       [region-hilite? (Region -> Boolean)]
                       [region-callback (Region -> (Option ((Listof (Instance Card%)) -> Any)))] ; fix this should be interface
                       [region-decided-start? (Region -> Boolean)]
                       [region-can-select? (Region -> Boolean)]
                       [set-region-decided-start?! (Region Boolean -> Void)]
                       [set-region-can-select?! (Region Boolean -> Void)]
                       [region-interactive-callback (Region -> (Option (Boolean (Listof (Instance Card%)) -> Any)))])