% ad lib
\version "2.18.2"
\include "articulate.ly"
#(set-global-staff-size 16)
% \tripletFeel 8 {
\pointAndClickOff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

mo = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cr = \change Staff = "right"
cl = \change Staff = "left"
rhMark = \markup { 
  \path #0.1 #'((moveto -1 0)(rlineto 0 -1.5)(rlineto 0.5 0))
}

\header {
  title = "Galop March"
}

d-d-d-high = \relative c''''{
    d4 d | d2 | cis8 e d b | cis4 b8 r8 | cis4 b8 d | cis4. b8 | \grace {b16 cis} b8 a d, e | fis2
    d'4 d | d2 | cis8 e d b | cis4 a8 r8 | \grace {a16 b} a8 gis a b | cis b a cis |\mo 1{e,4 fis8 gis | a4 a,}
}

d-d-d-low = \relative c''{
  \transpose c c, {\d-d-d-high}
}


d-d-d-high-accomp = \relative c'{
  <<
    {
      \repeat unfold 11 {\mo 1 {a4 b}}
      \mo 1 {a4 a fis fis}
    }
    \\
    {
      \repeat unfold 3 {r8 <d' fis> r q}
      \repeat unfold 3 {r8 <e g> r q}
      \repeat unfold 2 {r8 <d fis> r q}
      %%
      \repeat unfold 3 {r8 <d fis> r q}
      r8 <cis e> r q | r8 <a b> r q
     } 
  >>

  \clef bass
  <a cis e>8 b a cis | <gis e'>4 a8 b | a4 r |

  %%

  <<
    {
      \repeat unfold 3{r8 d r d}
      \repeat unfold 3{r8 cis r cis}
      \repeat unfold 2{r8 d r d}
      \repeat unfold 3{r8 d r d}
      r8 <cis e> r q | r <a b> r q| 
    }
    \\
    {
      \repeat unfold 3 {<fis a>4 <fis b>}
      \repeat unfold 3 {<g a>4 <g b>}
      \repeat unfold 2 {<fis a>4 <fis b>}
      %%
      \repeat unfold 3 {<fis a>4 <fis b>}
      a4 a | fis fis|
     } 
  >>

  \clef bass
  <a cis>8 b a cis | <gis e'>4 a8 b | a4 r |

}

d-d-d-low-accomp = \relative c,{
  \mo 1
  {
    \repeat unfold 3 {d8 r a r}
    \repeat unfold 3 {e'8 r a, r}
    \repeat unfold 2 {d8 r a r}
    %%
    \repeat unfold 3 {d8 r a r}
    e'8 r e r | dis r dis r | e4 r | e fis8 gis | a4 a,
  }

    \repeat unfold 3{d8 d' a, a'}
    \repeat unfold 3{e8 e' a,, a'}
    \repeat unfold 2{d,8 d' a, a'}
    %%
    \repeat unfold 3{d,8 d' a, a'}
    e8 e' e, e' | dis, dis' dis, dis' | <e, e'>4 r | e fis8 gis | a4 a,

}


%%%%%%%%%%%%%%%%%%%%%%
f-g-c-high = \relative c'''{
  fis16 g cis8 <cis g' a>8 q | q q q q| eis,16 fis b8 <b fis' a> q | q q q q |
  dis,16 e a8 a g | bis,16 cis fis8 fis e | cis d fis a | <cis, fis cis'> <fis b> <fis a>4|

  fis16 g cis8 <cis g' a>8 q | q q q q| eis,16 fis b8 <b fis' a> q | q q q q |
  dis,16 e a8 a g | bis,16 cis fis8 fis e | cis d fis a | <fis d'>4 r|
}

f-g-c-low = \relative c''{
  fis16 g cis8 <cis, cis'> q | q q q q| eis16 fis b8 <b, b'> q | q q q q |
  dis16 e a8 a g | bis,16 cis fis8 fis e | cis d fis a | cis b <a, fis' a>4|

   fis'16 g cis8 <cis, cis'> q | q q q q| eis16 fis b8 <b, b'> q | q q q q |
  dis16 e a8 a g | bis,16 cis fis8 fis e | cis d fis a | <d, d'>4 r|
}

f-g-c-high-accomp = \relative c'{
  \repeat unfold 2{r8 <a cis g'> r q}   \repeat unfold 2{r8 <a d fis> r q}
  \repeat unfold 2{r8 <a cis g'> a' q}   \repeat unfold 2{r8 <a, d fis> a' q}
  \repeat unfold 2{r8 <a, cis g'> r q}   \repeat unfold 2{r8 <a d fis> r q}
  \repeat unfold 2{r8 <a cis g'> a' q}   r8 <a, d fis> a' q | d,4 r |
  %%
  <<
    \clef bass
    {
      \mo 1{a,2 | b4. cis8 | d4. e8 | fis2 | fis4 g8 e | a2 | e4 fis8 d | a'2}
      \mo 1{a,2 | b4. cis8 | d4. e8 | fis2 | fis4 g8 e | a4. cis,8 |}
    }
  \\
    {
      r8 <e g> r q | r q8 r4 | r8 <fis a> r4 | r8 <a d> r q| r <a cis> r4 | r8 <cis g'> r q| r8 <a d> r4| r8 <d fis> r q|
      r8 <e, g> r q | r q8 r4 | r8 <fis a> r4 | r8 <a d> r q| r <a cis> r4 | r8 <cis g'> r4|
    }
  >>
  \mo1 {e,8 d} a'8 fis | d8
}

f-g-c-low-accomp = \relative c{
  \repeat unfold 3{
    \repeat unfold 2{e8 r a, r}
    \repeat unfold 2{d8 r a r}
  }
  \repeat unfold 2{e'8 r a, r}
  d8 r a r | \mo 1{d,4} r4
  %%
  \repeat unfold 3{
    \repeat unfold 2{e8 r \mo 1{a,8} r8}
    \repeat unfold 2{d8 r \mo 1{a8} r8}
  }
  \repeat unfold 2{e'8 r \mo 1{a,8} r8}
  \ottava #-1 {e'8 d \mo 1{a8 fis d8}}
}

romantic-orig-upper = \relative c''{
  <<
    {b4 d | e,2 | a8 gis b a | g4 d8 r| g4 a8 b| d2~|d8 cis fis e | d4 r|}
  \\
    {g,4 fis| e d | c2 | b2 | d2 | fis4 f | e g | fis4 r}
  >>
}

romantic-orig-lower = \relative c{
  g8 <d' g> b q | c <e g> b <e gis> | a, <e' a> d, <fis' c> | g, <d' g> g,, <g'' b> |
  e, <b' g'> e,, q | a <fis'' a> a, <gis' b> | a, g' <a, a'> g' | <d fis> d cis c| 
}

romantic-two-upper = \relative c''{
  <<
    {d4 f g,2 c8 b d c bes4 f8 r d'4 e8 f a2~ a8 g c, g' f2}
    \\
    {bes,4 a g f ees2 d d'4 des c cis d4 c a2}
  >>
}

romantic-two-lower = \relative c {
  bes8 <f' bes> d q
  ees <g bes> d <g b>
  c, <g' c> f, <ees' a>
  bes <f' bes> bes,, <bes'' d>
  g, <d' bes'> g,, <des'' bes'>
  c, <f' a> c <fis a>
  c <g' bes> c, <ees bes'>
  f, <f' a> f ees'
}

bes-upper = \relative c'''{
  f4 g | f8 d bes4 | d ees | d8 c f,4 | r8 c d ees | e f bes4~bes8 r r4| r2 | 
  \ottava #1 {
    \mo 1{f'4 g | f8 d bes4 | d ees | d8 c g4~|g8 a bes c d ees f g | a4 f |}
    } <bes d f>2
}

bes-lower = \relative c''{
  f4 g | f8 d bes4 | d ees | d8 c f,4 | r2 | r2 | r8 a bes d | f2 |
  f4 g | f8 d bes4 | d ees | d8 c g4~|g8 a bes c d ees f g | <c, ees f a>4 q | <bes d f bes>2|
}

bes-upper-accomp = \relative c{
  \repeat unfold 3 {r8 <f bes d> r q} | \repeat unfold 2 {r8 <f a ees'> r q}
  r8 <f bes d> r q | r <g bes c e> r q | <f a c f> \mo1 {fis8 g a} |

  r8 <f bes d f> r q |r q r q | r <g b f'> r q | \clef bass r <g c ees> r q | r <g bes ees g> r <ges bes ees ges> | <f bes d f>4 r|
  \clef treble <f' a c ees f>4 q | <f bes d f>2|
}

bes-lower-accomp = \relative c,{
  \ottava #-1 {
    \mo 1{bes8 r f r | bes r f r | bes r f r | c' r f, r | c' r f, r| bes r f r | g r c, r | f fis g a |
          bes8 r f r | bes r f r | g r g r | c, r c r | ees r ees r | f4 r | }
    }
  \ottava #0
    \mo 1{f f | bes2}
}


d-ees-a-upper = \relative c'''{
     d16 ees <a, a'>8 q q | q q q q |
     cis16 d <g, g'>8 q q | q q q q |
     b16 c \mo1{f,8 f ees}  | gis16 a \mo1{d,8 d c | a bes d f}
  }

d-ees-a-lower = \relative c'{
    f8 <a ees'> f q | f q f q | f <bes d> f q | f q f q | f8 <a ees'> f q | f q f q | f <bes d> f q |
}

d-ees-a-upper-accomp = \relative c'''{
  a2~a | g2~g| f2~f | 
}

d-ees-a-lower-accomp = \relative c'{
  c4 f, | c' f, | bes f | bes f | c' f, | c' f,| 
}

orig-upper-intro = \relative c''{
  \afterGrace <a a'>2 {b32 cis d e f g}| a4 \mo1 {e4 | f8 e d4 | e4 r |}
  \afterGrace <a, a'>2 {b32 cis d e f g}| a4 \mo1 {e4 | f8 e f4}
}

orig-lower-intro = \relative c{
  \afterGrace <a a'>2 {b32 cis d e f g}| a4 \mo1 {e4 | f8 e d4 | e4 r |}
  \afterGrace <a, a'>2 {b32 cis d e f g}| a4 \mo1 {e4 | f8 e f4}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
piano-one-upper = \relative c' {
  \clef treble
  \time 2/4
  \key d \major
  \tempo 4 = 144
  {
    \orig-upper-intro
    % benson trill
        \afterGrace g''2 {f32 g} | a8 \mo1 {gis8 a4~a8 gis a4~a8 gis a4~a8 gis a4}
        r2 r2 r4 a8 gis | \mo1 {a8 g fis e | d4 r}
        r2 r2 r2 
    \transpose d d, {\d-d-d-high     \d-d-d-high}
    \f-g-c-high-accomp r8 r4

    \key g\major  \clef treble
    \romantic-orig-upper
    \repeat unfold4{R1}
    \key bes\major              \bes-upper
    \ottava #0  {\d-ees-a-upper-accomp       f'2 | e4 \grace {dis8 e} f8 r|}
    \d-ees-a-upper  <bes, bes'>4 r
    \repeat unfold 8 {R2}
    \key a \major         \transpose bes a {\romantic-two-upper}
    \transpose bes a {\bes-upper-accomp}

    \key d \major
     \orig-upper-intro
     \afterGrace <g' g'>2 {f'32 g} | a8 r r4 | r2 r2 r2 | r2 r2 r2 r4
        g,16 a g fis | e fis e d cis d cis b | a b a g fis g fis e | d e d cis b cis b a | g a g fis e fis e d | 
        cis r gis' a ais b bis cis | d dis e eis fis g gis a | ais b bis cis d dis e eis | fis g gis a ais b bis cis
    \transpose d d, {\d-d-d-high     \d-d-d-high}
    \f-g-c-high-accomp
  }
  cis,,,,16( d e fis g a b8) <b fis'>8-. q <fis fis'>-. q <a e'>-. q-. <e e'>-. q-.
  <g d'>-. q-. <d d'>-. q-. q-. q-. q-. a'-. r <a d fis>4->~ q8 q-. q-. q-.
  <a d e>4-> q-> <a cis g'>4-> q->
  <a d fis>8-> \clef treble
  <fis' cis'>8-. q-. <cis cis'>-. q-. <e b'>-. q-. <b b'>-. q-. <d a'>-. q-. <a a'>-. q-.
  <c ees g>-. q-. <d f>
  <a d fis>-. \clef bass b,16 cis d e fis g gis a b cis d e fis g
  a8\( g16 fis e fis e d cis d cis b a g fis e\)
  \repeat unfold 15 { r16 <cis cis'> }
  r <e e'>
  R2 R2 <a cis e g>4-> r R2 <a d fis>4-> r R2 <d, d'>4 r q r q r
  \bar "|."
}

piano-one-lower = \relative c {
  \clef treble
  \time 2/4
  \key d \major
  {
    \transpose a a, {\orig-upper-intro}
    % benson trill
        \afterGrace g''2 {f32 g} | a8 r r4 | <d, a' d>2 <cis a' cis>4 r | <f a f'>2 <e a e'>4 r|
        r2 | a'8 gis a gis | a g fis e | d4 r | r2 r2 r2
        \transpose d d, { \d-d-d-low      \d-d-d-low }
    \clef bass      \f-g-c-low-accomp r8 r4

    \key g\major
    \ottava #0 {\romantic-orig-lower}
    \repeat unfold4{R1}
    \clef treble \key bes\major
    \bes-lower
    \ottava #0  \clef bass {\d-ees-a-lower-accomp       bes,4 f | bes f|}
    \clef treble    \d-ees-a-lower  bes 4  r| 
    \repeat unfold 8 {R2}
    \key a \major   \clef bass      \transpose bes a {\romantic-two-lower}
    \transpose bes a {\bes-lower-accomp}
    \key d \major

    \clef treble \transpose a a, {\orig-upper-intro}
    \afterGrace <g g'>2 {f'32 g} | a8 r8 r4| r2 r2 r2 |
        \repeat unfold 7 {g''16 fis g fis} r4 | r2 r2 r2 r2 r4
        ais,,,16 b bis cis | d dis e eis fis g gis a | ais b bis c d dis e eis | fis g gis a ais b bis cis|
    \transpose d d, { \d-d-d-low      \d-d-d-low }
    \clef bass      \f-g-c-low-accomp
    cis,,,,16 d e fis g a b8 \ottava #0 r r4
    R2 R2
    r8 <b, b'>8-. q-. <bes bes'>-. <a a'>-. r q4->~ q8 q-. q-. q-. q4-> q-> q-> q->
    <d d'>8-> r r4
    R2 R2
    r8 <c c'>8-. q-. <gis gis'>-. <a a'>
    b16\( cis d e fis g gis a b cis d e fis g\)
    a8\( g16 fis e fis e d cis d cis b a g fis e\)
    \repeat unfold 16 { <d d'>16 r }
    <fis fis'>4 r
    R2
    <a, a'>4-> r R2 <d d'>4-> r R2 \ottava #-1 <d, d'>4-> r q-> r q-> \ottava #0 r
  }

  \bar "|."
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
piano-two-upper = \relative c' {
  \clef treble
  \time 2/4
  \key d \major
  {
    \clef bass    \orig-lower-intro
        \clef treble <d g d'>2 | <cis a' cis>4 r | 
        \clef bass <f, a>2 <e a>4 r | <d a'>2 <cis a'>4 r| a'8 gis \mo 1{a8 gis | a gis a gis | a g fis e| d}
        <a' d fis>8 r q | \repeat unfold 3 {r8 <a d fis>8 r q}
    \clef treble  \d-d-d-high-accomp
    \clef treble
    \ottava #1 {\f-g-c-high   \f-g-c-high}

    \ottava #0
    \key g\major
    \repeat unfold 4{R1}
    \key bes\major
    \romantic-two-upper
    \bes-upper-accomp
    \d-ees-a-upper            \mo1{a''8 g f4}
    \d-ees-a-upper-accomp     f2 bes8 r r4
    \key ges \major         \transpose g ges {\romantic-orig-upper}
    \repeat unfold 8 {R2}
    \key a\major \transpose bes a {\bes-upper}
    \key d \major

    \ottava #0
     \clef bass    \orig-lower-intro
        \clef treble <d,, g d'>2 | <cis a' cis>8 
        \clef bass \relative c,{a16 b cis d e fis | g gis a b cis d e fis | g gis a b cis d e fis | \clef treble g gis a b cis d e fis|}
        \relative c'''{\repeat unfold 7{g16 fis g fis} r16 a g fis | e fis e d cis d cis b |  a b a g fis g fis e |
        \clef bass d e d cis b cis b a | g a g fis e f e d | cis a gis a ais b bis cis | d dis e eis fis g gis a | ais b bis cis \clef treble
        d dis e eis fis g gis a ais b bis cis} 
    \clef treble  \d-d-d-high-accomp
    \clef treble
    \ottava #1 {\f-g-c-high   \f-g-c-high}
    r8 <d'' b' d>8-. q-. <cis ais' cis>-. q-. <c a' c>-. q-. <b gis' b>-. q-.
    <bes g' bes>-. q-. <a fis' a>-. q-. <d gis>-. q-. <d g>-. <d fis>-.
    a''16\( g fis e d cis b a g fis e d cis b\)
    a\( gis a gis a b cis d e fis g a b cis d e\)
    fis8
    \mo 1 {
      fis,8-. fis-. eis-. eis-. e-. e-. dis-. dis-. d-. d-. cis-. cis-.
      c-. c-. bes-. a-. r fis'4->~ fis8 fis-. fis-. fis-. e4-> e-> a-> a->
      \repeat unfold 15 { r16 cis, } r16 e
    }
    R2 R2 <a cis e g a>4 r R2 \grace {a16 b cis} d4-> r R2 <d, d'>4-> r q-> r q->

    \ottava #0 r
  }
  \bar "|."
}

piano-two-lower = \relative c {
  \clef bass
  \time 2/4
  \key d \major
  {
    \clef bass      \orig-lower-intro
      <bes d bes'>2 <a e' a>4 r8 
      \ottava #-1 {\mo1 {gis,8 | a4. gis8 | a4. gis8 | a4. gis8 | a gis a gis | a gis a gis| a gis a gis| a g fis e|}}
      \mo1{d8} \ottava #0 r \mo1 {a'8 r|}  |   \repeat unfold 3 {\mo1{d8 r a r}}
    \d-d-d-low-accomp 
    \clef treble    \f-g-c-low    \f-g-c-low

    \key g\major                  \repeat unfold 4{R1}
    \key bes\major  \clef bass    \romantic-two-lower
    \bes-lower-accomp
    \clef treble                  \d-ees-a-lower    <e''' bes' cis>4 <f bes d>|
    \clef bass                    \transpose d d, {\d-ees-a-lower-accomp} bes,4 f | bes4 r4
    \key ges \major               \transpose g ges {\romantic-orig-lower}
    \repeat unfold 8 {R2}
    \key a\major  \clef treble   \transpose bes a {\bes-lower}
    \key d \major

     \clef bass      \orig-lower-intro
        <bes d bes'>2 <a e' a>8
        \ottava #-1
          \relative c,,{a16 b cis d e fis | \ottava #0 g gis a b cis d e fis | g gis a b cis d e fis | \clef treble g gis a b cis d e fis|}
          \relative c''{\repeat unfold 7{g16 fis g fis} r16 a g fis | e fis e d cis d cis b |  a b a g fis g fis e |
          \clef bass d e d cis b cis b a | g a g fis e f e d | cis a gis a ais b bis cis | d dis e eis fis g gis a | ais b bis cis \clef treble
          d dis e eis fis g gis a ais b bis cis} 

        \ottava #0
        \clef bass \d-d-d-low-accomp 
         \clef treble    \f-g-c-low    \f-g-c-low

  }
  r8 <b' d>8-. q-. <ais cis>-. q-. <a c>-. q-. <gis b>-. q-. <g bes>-. q-.
  <fis a>-. q-. <gis d' gis>-. q-.<g d' g>-. <fis d' fis>-.
  a''16\( g fis e d cis b a g fis e d cis b\)
  a\( gis a gis a b cis d e fis g a b cis d e\)
  fis8 <fis, ais>8-. q-. <eis gis>-. q-. <e g>-. q-. <dis fis>-. q-. <d f>-. q-.
  <cis e>-. q-. <c ees>-. q-. <bes d>-. <a d>-. r
  <d fis a d>4->~ q8 q-. q-. q-. <d e a d>4-> q-> <cis e a cis>-> q->
  \repeat unfold 16 { <d d'>16 r }
  <fis fis'>4 r R2 <a, cis e g a>4-> r R2 <a d fis a>4-> r R2 d4-> r d-> r d-> r
  \bar "|."
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\score {
  <<
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano I"
      \new Staff = "right-one" {
        \piano-one-upper
        % \articulate << \upper \pedals >>
      }
      %\new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left-one" {
        \piano-one-lower
        % \articulate << \lower \pedals >>
      }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano II"
      \new Staff = "right-two" {
        \piano-two-upper
        % \articulate << \upper \pedals >>
      }
      %\new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left-two" {
        \piano-two-lower
        % \articulate << \lower \pedals >>
      }
    >>

  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      % \Dynamics \RemoveEmptyStaves
    }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
  % \midi {}
}
