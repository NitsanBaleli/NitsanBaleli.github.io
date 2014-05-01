---
layout: post
title: Introduction to Sass (Syntactically Awesome StyleSheets)
---

Writing CSS can be very tedious.  
If you ever wrote a large CSS file you probably found yourself repeating rules all over the place,
ending up with a file that is very long and difficult to debug.

And to tell the truth, CSS is kind of dumb. 

For the purpose of making CSS a bit smarter and comfortable to handle, 
there are some CSS pre-processors out there aiming to make our life easier.

The one I like to use is called [Sass](https://www.sass-lang.com)

>Over and over again, the industry is choosing Sass as the premier CSS extension language.

## Requirements

You'll need to have [Ruby](www.ruby-lang.org) installed, along with [RubyGems](http://rubygems.org/pages/download).

## Install

Now we can install Sass, in the command line we'll type:

```bash 
gem install sass

sass -v
```

If the last line returns Sass's current version, that means it is installed successfully.


## Go and play

Open a new file and name it `style.sass`:

```sass
$main-color: red
$sec-color: green
$padding: 5px

div.wrapper
  background-color: $main-color
  padding: $padding

  h1.main-title
    color: $sec-color
```

Now from the command line, type

```bash
sass style.sass style.css
```

Now a style.css should be created, and inside:

```css
div.wrapper {
  background-color: red;
  padding: 5px; }
  div.wrapper h1.main-title {
    color: green; }
```

---

Sass supports many nice features such as:
Variables, Loops, Includes, Color and String operations as well as Math operations.

See the [documentation](http://sass-lang.com/documentation/file.SASS_REFERENCE.html) for a clear list of all you can do.

Have fun, 
And remember that like with every tool, 
You have to use it responsibly. 