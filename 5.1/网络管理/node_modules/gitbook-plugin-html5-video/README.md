gitbook-plugin-html5-video
==============

This plugin helps you to include `Video` tag in your html5 pages.

This plugins requires gitbook `>=2.0.0`.

### Setup

Add it to your `book.json`, then run `gitbook install`:

```
{
    plugins: ["html5-video"]
}
```

### Write in gitbook-markdown.md

```
1. {% video %}https://www.domain.com/video.mp4{% endvideo %}

2. {% video width="740", height="350" %}https://www.domain.com/video.mp4{% endvideo %}

3. {% video width="740", height="350", loop="loop", controls="controls" %}https://www.domain.com/video.mp4{% endvideo %}
...

```

### gitbook build result.
```
<video src="https://www.domain.com/video.mp4" width="100%" height="100%"></video>

<video src="https://www.domain.com/video.mp4" width="740" height="350"></video>

<video src="https://www.domain.com/video.mp4" width="740" height="350" controls="controls" loop="loop"></video>
```
