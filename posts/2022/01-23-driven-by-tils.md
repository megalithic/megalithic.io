%{
title: "Driven by TILs",
tags: ["til", "elixir", "phoenix"],
description: """
I've come to realize that the only way I'll post more often, is to have a
platform that makes it easy to post more often. There's been a higher
percentage of TIL posts from all the folks I follow only twitter (for the last
year or so). It dawned on me that _this_ is the way.
"""
}

---

> You can just keep sharpening the axe, or, you can actually use it to build things.

I am one who wants to build tools to help bring efficiencies to the building of things, but really, I just want to build the tools, and keep iterating on the tools. My website suffers from this same trait. I've long wanted to redesign and rebuild my website, but I just end up spending time sharpening the axe instead of actually getting the axe out and using it.

The increase in _TIL_ blog posts and websites have really been inspiration for me to just design and build (in public), and have a way to just _write_ (even if it really is a simple idea, that, potentially others might find useful).

So, in an unspoken challenge from [@evantravers](https://evantravers.com) I will be pushing updates to the site, along with blog posts. It doesn't matter what the website change is, as long as there is something written about to go along with it.

### You've got to start from somewhere

I knew I'd need a quick way, that fits into my current workflow, to encourage me to write. What better way to do that, than to build a quick tool to facilitate it!

#### Introducing [`til`](https://github.com/megalithic/dotfiles/blob/main/bin/til) ->

```bash
$ til Driven by TILs
```

It's really that simple; I just call my script, it takes the rest of the string you type as a parameter, and ultimately builds out the elixir-based frontmatter that [NimblePublisher](https://github.com/dashbitco/nimble_publisher) requires.

What's really neat, is I end up in my editor of choice, [neovim](https://github.com/neovim/neovim), with my cursor in the `description` heredoc ready to start typing.

```elixir
%{
title: "Driven by TILS",
tags: ["til"],
description: """

"""
}
---
```

Additionally, using [`FZF`](https://github.com/junegunn/fzf), I'm able to take that same "title" string that I passed in to `til` and fuzzy-find for that matching string to just open the markdown document and start editing it (from any where on my system, the correct `cwd` gets set in nvim to my posts directory). It makes for a great way to have easy access to all of your blog posts. It also breaks down any friction I've had previously to just get to writing and publishing TILs and other blog posts.

Please give my [`til`](https://github.com/megalithic/dotfiles/blob/main/bin/til) tool a looksy; I'd love to hear feedback!

I hope to implement [@evantravers' way of using git commit messages to generate a CHANGELOG](https://evantravers.com/articles/2019/11/08/using-git-to-generate-a-changelog-for-your-blog/) for each blog post, soon. Neat, eh?

More to come -- [learn (and build) in public](https://www.swyx.io/learn-in-public/), amirite?
