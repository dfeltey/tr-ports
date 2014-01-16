#lang typed/racket
(require (prefix-in mred: typed/racket/gui)
         "list-hash.rkt") 
(provide Mode Orientation Suit Card% Dir)

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
                       [region-callback (Region -> (Option (case-> (-> Any) ((Listof (Instance Card%)) -> Any))))] ; fix this should be interface
                       [region-decided-start? (Region -> Boolean)]
                       [region-can-select? (Region -> Boolean)]
                       [set-region-decided-start?! (Region Boolean -> Void)]
                       [set-region-can-select?! (Region Boolean -> Void)]
                       [region-interactive-callback (Region -> (Option (Boolean (Listof (Instance Card%)) -> Any)))])

(define-type Dir (U 'n 'e 's 'w)) 
(define-type Mode (U 'cw 'ccw 0 90 -90 180 -180 270 -270 360))
(define-type Orientation (U 0 90 180 270))
(define-type Suit (U 'clubs 'diamonds 'hearts 'spades 'unknown))
(define-type Card%
  (Class #:implements mred:Snip%
         (init [-suit-id Any]
               [-value Any]
               [-width Natural]
               [-height Natural]
               [-front (Instance mred:Bitmap%)]
               [-back (Instance mred:Bitmap%)]
               [-mk-dim-front (-> (Instance mred:Bitmap%))]
               [-mk-dim-back (-> (Instance mred:Bitmap%))]
               [-rotated-bms (Hash (Pairof Dir (Instance mred:Bitmap%)) (Instance mred:Bitmap%))])
         [card-width (-> Natural)]
         [card-height (-> Natural)]
         [flip (-> Void)]
         [face-up (-> Void)]
         [face-down (-> Void)]
         [face-down? (-> Boolean)]
         [rotate (Mode -> Void)]
         [orientation (-> Orientation)]
         [get-suit-id (-> Any)]
         [get-suit (-> Suit)]
         [get-value (-> Any)]
         [semi-flip (-> Void)]
         [user-can-flip (case-> (-> Boolean)
                                (Any -> Void))]
         [user-can-move (case-> (-> Boolean)
                                (Any -> Void))]
         [snap-back-after-move (case-> (-> Boolean)
                                       (Any -> Void))]
         [stay-in-region (case-> (-> (Option Region))
                                 ((Option Region) -> Void))]
         [home-region (case-> (-> (Option Region))
                              ((Option Region) -> Void))]
         [dim (case-> (-> Boolean)
                      (Any -> Void))]
         [remember-location ((Instance mred:Editor<%>) -> Boolean)]
         [back-to-original-location ((Instance mred:Pasteboard%) -> Void)]))