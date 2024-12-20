# Guide to Using Route Management

When a new page is created, a route for the page is typically created simultaneously. You can also maintain the entire APP's routes through the "Route Management" feature. Routes are designed with two levels: the first level is the "Navigation Layout" route, and the second level is the page route.

## Pages and Routes

1. When creating a new page, you need to fill in the page's route. You can see that the final route of the page consists of the navigation layout (route) + page route.

<img src="./images/routemanage-createpage.png" width="80%">

> If you want to create or modify a navigation layout, you can access the "Navigation Layout Management."

2. To modify a page's route, since pages and routes are mutually bound, you need to choose an unused route when modifying. Below are the common entry points for modifying page routes.

<img src="./images/routemanage-modifyroute.png" width="80%"><br>
(1) "Page Development" left-side layout and page list<br>

<img src="./images/routemanage-modifyroute2.png" width="350px"><br>
(2) Edit Page - Right-side "Page Configuration" panel

## Managing APP Routes

In the "**Route Management**" feature, you can manage the entire APP's routes. The left side of the page lists route links, and the corresponding right side allows binding pages or redirecting routes. APP routes are a two-level tree structure, with the first level being the "Navigation Layout" route and the second level being the page route.

<img src="./images/routemanage-entry.png" width="80%">

To add a first-level route, which is the navigation layout route, you need to add a first-level route by creating a new navigation layout.

<img src="./images/routemanage-layoutroute.png" width="80%">

To add a second-level route, you can continue to add routes under a first-level route and bind a page or redirect route to the route after adding it.

<img src="./images/routemanage-addsubroute.png" width="80%">

<img src="./images/routemanage-bindroute.png" width="80%">

To unbind a route, deleting a route will unbind the route. If a route of a page is deleted, you can rebind a route to that page.

<img src="./images/routemanage-rebindroute.png" width="80%"><br>
(Page A's route pagea is deleted, then rebound with another route)
