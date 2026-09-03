# ETMLM, the evolution of TTML



If you thought TTML was basic, ETMLM is its advanced version. Designed specifically for song lyrics, it adds some very advanced and specific features.



##### Syntax highlighting, custom file icon and language support for **ETMLM** (*Enhanced Timed Multi Lyrics Markup*) inside Visual Studio Code.



Please, note that you can code in ETMLM, but for now it's kinda useless because there isn't an existing “reading module” (an XML parser) to be integrate it into a players' code. Obviously I will make one.

ETMLM is an advanced, TTML-based markup format for time-synced lyrics that supports:

* Up to **5 singer positions**: far-left, center-left, center, center-right, far-right.
* Up to **3 background vocal layers** before *and* after the main vocal line (everyone with their own time stamps).
* Per-word/per-syllable/per-phoneme timing and visual effects (brighten, blur, fade, movement).
* Rich metadata (composer, album, ISRC, BPM, key, mood, etc.).
* Custom render styles for "live" (karaoke-style where you control the **fill part**) and "simple" (how the lyrics appear *before* the fill) rendering modes.

This extension provides:

* Syntax highlighting for `.etmlm` files, distinguishing:

  * Classic TTML tags (`p`, `span`, `div`, `body`, `head`, `tt`, `metadata`, `ttm:agent`, ...).
  * Custom/new ETMLM tags (`brighten.word`, `role.positioning`, `text.render.live`, `composer:meta`, ...).
  * Lyric text content.
  * Attribute names, values and operators.
* A custom file icon for `.etmlm` files (via the **ETMLM Icon Pack** icon theme).
* Auto-closing tags/quotes, bracket matching, code folding and smart indentation for ETMLM's XML-based structure.

## 

## Getting Started



1. Run the `.bat` file **as admin** so you get the custom `.ico` for the ETMLM files on VSC.
2. Install the extension (VSIX).
3. Open or create a `.etmlm` file — syntax highlighting applies automatically.
4. (Optional) Enable the **ETMLM Icon Pack** via `File > Preferences > File Icon Theme` to get the custom `.etmlm` file icon.



## Full Example for only 1 Line of Lyric (Explanation below)



```xml
<?xml version="1.0" encoding="UTF-8"?>
<etmlm xmlns:x="http://w3.org" 
       xmlns:composer="http://w3.org/composer" 
       xmlns:ttm="http://w3.org/ttm" 
       xmlns:style="URL for your style to bypass text.style and etmlm.edit; otherwise, create your own"
       xml:lang="en" 
       timing.default="phoneme" 
       timing.secondary="syllable" 
       timing.other="true" 
       timing.other.count="1" 
       timing.other.id="word">
  <etmlm.edit>
  <!-- If it is “false”: value="false" password="true/false" password.edit.word=“AbCd1234@yOU!!!” -->
     <body.edit value="true">
      <time.stamps.edit value="true">
        <p.edit value="true"></p.edit>
        <span.edit value="true"></span.edit>
        <pre.edit value="true"></pre.edit>
        <sub.edit value="true"></sub.edit>
      </time.stamps.edit>
     </body.edit>
     <text.style.edit value="true"></text.style.edit>
     <metadata.edit value="true"></metadata.edit>
  </etmlm.edit>
  <head>
    <metadata>
      <title>Concept</title>
      <composer:meta key="artists" value="Iosif Telegaru"/>
      <composer:meta key="album" value="Example of ETMLM"/>
      <ttm:agent xml:id="v1" type="person" default.position="R2">
        <ttm:name>Lead</ttm:name>
      </ttm:agent>
      <ttm:agent xml:id="v1000" type="group" default.position="x1.1-bg, x1.2-bg, x1.3-bg">
        <ttm:name>Pre-Harmony</ttm:name>
      </ttm:agent>
      <ttm:agent xml:id="v2000" type="group" default.position="x2.1-bg, x2.2-bg, x2.3-bg">
        <ttm:name>Sub-Harmony</ttm:name>
      </ttm:agent>
      <ttm:agent xml:id="v2" type="person" default.position="L2">
        <ttm:name>Secondary</ttm:name>
      </ttm:agent>
    </metadata>
  </head>
  <text.style>
    <word.effects>
      <before.time opacity="10%" opacity.behavor="decreasing" blur="gaussian blur" blur.value="30%" blur.behavior="increasing" blur.style="homogeneous"></before.time>
      <after.time opacity="30%" opacity.behavor="decreasing" blur="gaussian blur" blur.value="15%" blur.behavior="increasing" blur.style="homogeneous"></after.time>
      <brighten.word same="false" count="4" duration.defalt="2s" duration.permission="increasing" delay.default="0.1s" increase.velocity.all="true" increase.velocity="2.5s" decrease.velocity.all="true" decrease.velocity="1.5s">
        <brighten id="1" value="phoneme" font.style="bold" font.size="+5pts" font.rise="+10px" brighten.color="#FFFF00" layer="behind" outline="30px" intensity="50%" feather="70%"></brighten>
         <brighten id="2" value="syllable" font.style="bold" font.size="+6pts" font.rise="+12px" brighten.color="#686820" layer="in front" outline="30px" intensity="50%" feather="70%"></brighten>
         <brighten id="3" value="word" font.style="bold" font.size="+7pts" font.rise="+15px" brighten.color="#FFFF30" layer="id.1" outline="30px" intensity="50%" feather="70%"></brighten>
         <brighten id="4" value="phrase" font.style="bold" font.size="+9pts" font.rise="+20px" brighten.color="#FFFF40" layer="id.2" outline="30px" intensity="50%" feather="70%"></brighten>
      </brighten.word>
      <word.movement rise.style="exponential in out" smooth="true" smoothness="0.5"></word.movement>
      <word.appearance style="fade in out" style.duration="2s"></word.appearance>
    </word.effects>
    <role.positioning value="L2" text-align="left" left="50%"></role.positioning>
    <role.positioning value="L1" text-align="left" left="100%"></role.positioning>
    <role.positioning value="C" text-align="center" left="5%" transform="translateX(-50%)"></role.positioning>
    <role.positioning value="R2" text-align="right" right="50%"></role.positioning>
    <role.positioning value="R1" text-align="right" right="100%"></role.positioning>
    <text.render.live text.render.same="false">
       <render.color id="v1" value="#FFFFFF" font.family="Plack Com Balck.ttf" font.type="italic" alpha="100" feather="30%"></render.color>
       <render.color id="v2" value.gradient="#FFFFFF, #B692F47" font.family="Plack Com Balck.ttf" font.type="regular" alpha="100" feather="id.v1"></render.color>
       <render.color id="v1000" value="#FFFFFF" font.family="poppins.ttf" font.type="bold" alpha="80" feather="40%"></render.color>
       <render.color id="v2000" value="#FFFFFF" font.family="poppins.ttf" font.type="bold italic" alpha="80"feather="10%"></render.color>
    </text.render.live>
    <text.render.simple text.render.same="false">
       <default.color id="v1" value="#000000" font.family="Plack Com Balck.ttf" font.type="bold" alpha="100"></default.color>
       <default.color id="v2" value="#000000" font.family="Plack Com Balck.ttf" font.type="bold" alpha="100"></default.color>
       <default.color id="v1000" value="#000000" font.family="poppins.ttf" font.type="regular" alpha="80"></default.color>
       <default.color id="v2000" value="#000000" font.family="poppins.ttf" font.type="bold italic" alpha="80"></default.color>
    </text.render.simple>
  </text.style>
<body>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h1>Lyrics</h1>
        <p begin="0:00.000" end="0:05.000" agent="v1" position.default.only="false" positions.count="2">
          <position id="1" value="R2" begin="0:00.000" end="0:02.500"></position>
          <position id="2" value="L2" begin="0:02.500" end="0:05.000"></position>
           <pre role="x1.1-bg" begin="0:41.100" end="0:43.800">
             <pre.span role="x1.1-bg" begin="0:41.100" end="0:42.000">Hello, </pre.span>
             <pre.span role="x1.1-bg" begin="0:42.000" end="0:43.500">world</pre.span>
           </pre>
           <pre role="x1.2-bg" begin="0:41.100" end="0:43.800">
             <pre.span role="x1.2-bg" begin="0:41.800" end="0:42.800">(choir </pre.span>
             <pre.span role="x1.2-bg" begin="0:42.800" end="0:44.800">harmony)</pre.span>
           </pre>
           <pre role="x1.3-bg" begin="0:41.100" end="0:43.800">
             <pre.span role="x1.3-bg" begin="0:41.800" end="0:43.100">Nothing more</pre.span>
           </pre>
          <span begin="0:44.000" end="0:44.500">I </span>
          <span begin="0:44.500" end="0:45.200">want </span>
          <span begin="0:45.200" end="0:46.000">you...</span>
           <sub role="x2.1-bg" begin="0:45.500" end="0:48.000">
             <sub.span role="x2.1-bg" begin="0:45.500" end="0:46.000">(want </sub.span>
             <sub.span role="x2.1-bg" begin="0:46.000" end="0:46.600">you </sub.span>
             <sub.span role="x2.1-bg" begin="0:46.600" end="0:47.200">so </sub.span>
             <sub.span role="x2.1-bg" begin="0:47.200" end="0:47.900">bad)</sub.span>
           </sub>
           <sub role="x2.2-bg" begin="0:45.500" end="0:48.000">
             <sub.span role="x2.2-bg" begin="0:46.000" end="0:46.800">high </sub.span>
             <sub.span role="x2.2-bg" begin="0:46.800" end="0:47.800">harmony</sub.span>
           </sub>
           <sub role="x2.3-bg" begin="0:45.500" end="0:48.000">
             <sub.span role="x2.3-bg" begin="0:46.500" end="0:47.500">low </sub.span>
             <sub.span role="x2.3-bg" begin="0:47.500" end="0:48.000">whisper</sub.span>
           </sub>
        </p>
      </div>
    </div>
  </div>
</body>
</etmlm>
```

## Roadmap



* \[ ] Official ETMLM format specification (public draft).
* \[ ] Reference player/renderer supporting ETMLM's multi-position and multi-layer vocal features.
* \[ ] Snippets for common ETMLM structures (`p`, `pre`/`sub` background blocks, `text.style` boilerplate).
* \[ ] Live validation / linting against the ETMLM spec.

## 

## Let's Clear this out



The most things in ETMLM are taken from the original TTML as both are based on XML, but let's explain what the new parts are.

First, we notice this:

```xml
 xmlns:style="URL for your style to bypass text.style and etmlm.edit; otherwise, create your own"
       xml:lang="en" 
       timing.default="phoneme" 
       timing.secondary="syllable" 
       timing.other="true" 
       timing.other.count="1" 
       timing.other.id="word">
```

The `xmlns:style` is to insert the URL of your own style, like the Apple Music: `xmlns:itunes="http://music.apple.com/lyric-ttml-internal"`. But don't worry, you can create your own.

The `timing.default="phoneme"`, `timing.secondary="syllable"` and `timing.other.id="word"` indicates how precise the syncing is and how many levels of precision are across the song (it's just metadata).

Now, this:

```xml
  <etmlm.edit>
  <!-- If it is “false”: value="false" password="true/false" password.edit.word=“AbCd1234@yOU!!!” -->
     <body.edit value="true">
      <time.stamps.edit value="true">
        <p.edit value="true"></p.edit>
        <span.edit value="true"></span.edit>
        <pre.edit value="true"></pre.edit>
        <sub.edit value="true"></sub.edit>
      </time.stamps.edit>
     </body.edit>
     <text.style.edit value="true"></text.style.edit>
     <metadata.edit value="true"></metadata.edit>
  </etmlm.edit>
```

Yeah, it's protection. So, basically, you can let any person edit, for example, the body when `value="true"`, or password-protect it. And, yes, `<body.edit>`. `<text.style.edit>` and `<metadata.edit>` work independently, so you can use different passwords for each one. And if you **don't** want anyone, not even you, editing one part, just write ` <text.style.edit value="false">` without the password and it will never be accesible again unless you have the original `.etmlm`.

\---

Now we start with THE part.

```xml
<text.style>
    <word.effects>
      <before.time opacity="10%" opacity.behavor="decreasing" blur="gaussian blur" blur.value="30%" blur.behavior="increasing" blur.style="homogeneous"></before.time>
      <after.time opacity="30%" opacity.behavor="decreasing" blur="gaussian blur" blur.value="15%" blur.behavior="increasing" blur.style="homogeneous"></after.time>
      <brighten.word same="false" count="4" duration.defalt="2s" duration.permission="increasing" delay.default="0.1s" increase.velocity.all="true" increase.velocity="2.5s" decrease.velocity.all="true" decrease.velocity="1.5s">
        <brighten id="1" value="phoneme" font.style="bold" font.size="+5pts" font.rise="+10px" brighten.color="#FFFF00" layer="behind" outline="30px" intensity="50%" feather="70%"></brighten>
         <brighten id="2" value="syllable" font.style="bold" font.size="+6pts" font.rise="+12px" brighten.color="#686820" layer="in front" outline="30px" intensity="50%" feather="70%"></brighten>
         <brighten id="3" value="word" font.style="bold" font.size="+7pts" font.rise="+15px" brighten.color="#FFFF30" layer="id.1" outline="30px" intensity="50%" feather="70%"></brighten>
         <brighten id="4" value="phrase" font.style="bold" font.size="+9pts" font.rise="+20px" brighten.color="#FFFF40" layer="id.2" outline="30px" intensity="50%" feather="70%"></brighten>
      </brighten.word>
      <word.movement rise.style="exponential in out" smooth="true" smoothness="0.5"></word.movement>
      <word.appearance style="fade in out" style.duration="2s"></word.appearance>
    </word.effects>
    <role.positioning value="L2" text-align="left" left="50%"></role.positioning>
    <role.positioning value="L1" text-align="left" left="100%"></role.positioning>
    <role.positioning value="C" text-align="center" left="5%" transform="translateX(-50%)"></role.positioning>
    <role.positioning value="R2" text-align="right" right="50%"></role.positioning>
    <role.positioning value="R1" text-align="right" right="100%"></role.positioning>
    <text.render.live text.render.same="false">
       <render.color id="v1" value="#FFFFFF" font.family="Plack Com Balck.ttf" font.type="italic" alpha="100" feather="30%"></render.color>
       <render.color id="v2" value.gradient="#FFFFFF, #B692F47" font.family="Plack Com Balck.ttf" font.type="regular" alpha="100" feather="id.v1"></render.color>
       <render.color id="v1000" value="#FFFFFF" font.family="poppins.ttf" font.type="bold" alpha="80" feather="40%"></render.color>
       <render.color id="v2000" value="#FFFFFF" font.family="poppins.ttf" font.type="bold italic" alpha="80"feather="10%"></render.color>
       </color.transform>
    </text.render.live>
    <text.render.simple text.render.same="false">
       <default.color id="v1" value="#000000" font.family="Plack Com Balck.ttf" font.type="bold" alpha="100"></default.color>
       <default.color id="v2" value="#000000" font.family="Plack Com Balck.ttf" font.type="bold" alpha="100"></default.color>
       <default.color id="v1000" value="#000000" font.family="poppins.ttf" font.type="regular" alpha="80"></default.color>
       <default.color id="v2000" value="#000000" font.family="poppins.ttf" font.type="bold italic" alpha="80"></default.color>
    </text.render.simple>
  </text.style>
```

If you're... special let's say, and want to make your own effect inside the ETMLM file... YOU CAN, no need of using any URL. Guess I'll need to make a proper app that renders ETMLM and where you can make ETMLM from scratch.

### 

### The Word Effects Part:



```xml
 <word.effects>
      <before.time opacity="10%" opacity.behavor="decreasing" blur="gaussian blur" blur.value="30%" blur.behavior="increasing" blur.style="homogeneous"></before.time>
      <after.time opacity="30%" opacity.behavor="decreasing" blur="gaussian blur" blur.value="15%" blur.behavior="increasing" blur.style="homogeneous"></after.time>
      <brighten.word same="false" count="4" duration.defalt="2s" duration.permission="increasing" delay.default="0.1s" increase.velocity.all="true" increase.velocity="2.5s" decrease.velocity.all="true" decrease.velocity="1.5s">
        <brighten id="1" value="phoneme" font.style="bold" font.size="+5pts" font.rise="+10px" brighten.color="#FFFF00" layer="behind" outline="30px" intensity="50%" feather="70%"></brighten>
         <brighten id="2" value="syllable" font.style="bold" font.size="+6pts" font.rise="+12px" brighten.color="#686820" layer="in front" outline="30px" intensity="50%" feather="70%"></brighten>
         <brighten id="3" value="word" font.style="bold" font.size="+7pts" font.rise="+15px" brighten.color="#FFFF30" layer="id.1" outline="30px" intensity="50%" feather="70%"></brighten>
         <brighten id="4" value="phrase" font.style="bold" font.size="+9pts" font.rise="+20px" brighten.color="#FFFF40" layer="id.2" outline="30px" intensity="50%" feather="70%"></brighten>
      </brighten.word>
      <word.movement rise.style="exponential in out" smooth="true" smoothness="0.5"></word.movement>
      <word.appearance style="fade in out" style.duration="2s"></word.appearance>
    </word.effects>
```

It provide a basic, **but complete catalog** of effects for the lyrics so it's dynamic and properly animated. Not much, but, in the end, it's for lyrics, with blur and fade in out you're done. It's not like you would need somethings like `rise.style="fragments"`... *or yes?*

Anyways, here we have:

* `<before.time>`, that let you animate how the lyrics appear *before* they're fill ***(please, do not notice the double meaning).***
* `<after.time>`, it's like `<before.time>` but for when the lyrics rise up and disappear after being sung: **HOW** do you want them disappearing? That's the question.

All of them supporting blur, blur type, blur value, blur behavior (if its value increases or decreases), etc.

* `<brighten.word>`, where you can customize how the words bright up if their duration is more that the seconds you want.

  * You can choose if you want to brighten up a whole phrase or only a phoneme, and how by using `value="[synced-level]"` and customizing the font, how it rises up when it brightens up, the color, the intensity, how the shine increases and decreases, if the shine it's behind or in front of the text, and many more.
* `<word.movement>` it's how the text moves when it rises.
* `<word.appearance>` is used to describe the animation that the text uses to appear or dissapear.

  *(I cannot say "the only supported animations are: ..." because I don't have a code renderer, but when I'll do have one, I'll update this READ ME)*

\---

```xml
    <role.positioning value="L2" text-align="left" left="50%"></role.positioning>
    <role.positioning value="L1" text-align="left" left="100%"></role.positioning>
    <role.positioning value="C" text-align="center" left="5%" transform="translateX(-50%)"></role.positioning>
    <role.positioning value="R2" text-align="right" right="50%"></role.positioning>
    <role.positioning value="R1" text-align="right" right="100%"></role.positioning>
```

This part defines the text alignment, for example, the L2 is 50% aligned "Left", meaning "Center-Left".

\---

```xml
 <text.render.live text.render.same="false">
       <render.color id="v1" value="#FFFFFF" font.family="Plack Com Balck.ttf" font.type="italic" alpha="100" feather="30%"></render.color>
       <render.color id="v2" value.gradient="#FFFFFF, #B692F47" font.family="Plack Com Balck.ttf" font.type="regular" alpha="100" feather="id.v1"></render.color>
       <render.color id="v1000" value="#FFFFFF" font.family="poppins.ttf" font.type="bold" alpha="80" feather="40%"></render.color>
       <render.color id="v2000" value="#FFFFFF" font.family="poppins.ttf" font.type="bold italic" alpha="80"feather="10%"></render.color>
    </text.render.live>
```

We got to the custom render styles, this part is for the fill part (I don't know how to call it). You can:

* Select a diferent fill fo every `<ttm:agent>`.
* Choose the font family the it's type (bold, regular, italic) you want for everyone. You can chose the path of the font or a URL.
* Choose the color of the fill, you can even choose gradients.
* Select the opacity of the fill for every lyric.
* The feather of the fill (the transition between the fill color and the original color.

```xml
    <text.render.simple text.render.same="false">
       <default.color id="v1" value="#000000" font.family="Plack Com Balck.ttf" font.type="bold" alpha="100"></default.color>
       <default.color id="v2" value="#000000" font.family="Plack Com Balck.ttf" font.type="bold" alpha="100"></default.color>
       <default.color id="v1000" value="#000000" font.family="poppins.ttf" font.type="regular" alpha="80"></default.color>
       <default.color id="v2000" value="#000000" font.family="poppins.ttf" font.type="bold italic" alpha="80"></default.color>
    </text.render.simple>
  </text.style>
```

Here you change *how* the lyrics are shown before they are sung.

* Change the color (including gradients), font and opacity for every `<ttm:agent>`.

In both `<text.render.simple>` and `<text.render.live>`, you can save time by putting `text.render.same="true"`, so you just need to put one line of data and it will apply for every agent.

\---

## 

## THE LYRICS



Finally, we arrived at the lyrics part. It's the same as TTML, but with new parts:

### 

### 1: The `<pre>`:



```xml
  <pre role="x1.1-bg" begin="0:41.100" end="0:43.800">
     <pre.span role="x1.1-bg" begin="0:41.100" end="0:42.000">Hello, </pre.span>
     <pre.span role="x1.1-bg" begin="0:42.000" end="0:43.500">world</pre.span>
  </pre>
  <pre role="x1.2-bg" begin="0:41.100" end="0:43.800">
     <pre.span role="x1.2-bg" begin="0:41.800" end="0:42.800">(choir </pre.span>
     <pre.span role="x1.2-bg" begin="0:42.800" end="0:44.800">harmony)</pre.span
  </pre>
    <pre role="x1.3-bg" begin="0:41.100" end="0:43.800">
    <pre.span role="x1.3-bg" begin="0:41.800" end="0:43.100">Nothing more</pre.span>
  </pre>
```

It's where the BGV that are sung *before* the lead vocal are put.

### 

### 2: The `<sub>`



```xml
           <sub role="x2.1-bg" begin="0:45.500" end="0:48.000">
             <sub.span role="x2.1-bg" begin="0:45.500" end="0:46.000">(want </sub.span>
             <sub.span role="x2.1-bg" begin="0:46.000" end="0:46.600">you </sub.span>
             <sub.span role="x2.1-bg" begin="0:46.600" end="0:47.200">so </sub.span>
             <sub.span role="x2.1-bg" begin="0:47.200" end="0:47.900">bad)</sub.span>
           </sub>
           <sub role="x2.2-bg" begin="0:45.500" end="0:48.000">
             <sub.span role="x2.2-bg" begin="0:46.000" end="0:46.800">high </sub.span>
             <sub.span role="x2.2-bg" begin="0:46.800" end="0:47.800">harmony</sub.span>
           </sub>
           <sub role="x2.3-bg" begin="0:45.500" end="0:48.000">
             <sub.span role="x2.3-bg" begin="0:46.500" end="0:47.500">low </sub.span>
             <sub.span role="x2.3-bg" begin="0:47.500" end="0:48.000">whisper</sub.span>
           </sub>
```

Where you find the lyrics that are sung *at the same time* of *after* the Lead Vocal.

Both `<pre>` and `<sub>` have up to three independent BGV lines.

### 

### 3: Panning



```xml
 <p begin="0:00.000" end="0:05.000" agent="v1" position.default.only="false" positions.count="2">
          <position id="1" value="R2" begin="0:00.000" end="0:02.500"></position>
          <position id="2" value="L2" begin="0:02.500" end="0:05.000"></position>
```

Last, but not least, we have the position panning, meaning you can make a line start on the Left (L1) and finish on the right (R2), with its corresponding time stamps. You can add as many positions you want in the `positions.count="[value]"`.

## 

## Contributing



Issues and pull requests are welcome! This project is in early development as the ETMLM format itself is still evolving.

## 

## License



MIT © Iosif Beniamin Telegaru

