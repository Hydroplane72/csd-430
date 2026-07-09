# Layered System

## What is a Layered System?
In REST, a layered system works by ensuring the client doesn't talk directly to the service that handles the request. Normally, you have things called intermediary layers. These layers can include load balancers, proxies, gateways, caches, and/or security filters. Each request must pass through these layers before the service API can handle it. What this does is allow for the client to hit a "server" and have multiple checks against each call to handle the request properly. The main point of a layered approach is that a client doesn't need to know that all of this happens for each request. 

## How does it work?
In essence, a layered approach involves routing requests through multiple intermediaries, each serving a specific function. The request must pass through each of these layers before it reaches the actual service that handles the request.

Here are a couple of REST Layers that are pretty common to see: ( Generally, requests go through each of these layers from top to bottom)

- Client Layer
    - Browsers, mobile apps, backend services

- Edge Layer
    - Reverse Proxy, Web Application Firewall

- Routing Layer
    - Load Balancer, API Gateways

- Service Layer
    - Microservices, Domain Services, Business Logic here

- Data Layer
    - Databases, caches, storage systems

## Why should you care?

There are multiple reasons why you should care about a layered system approach.

### 1. Scalability

 The routing layer provides the option to load-balance services with heavy loads. 

### 2. Security

 Security logic can be housed in the edge layer and shared across multiple API services. This allows for quick and easy updates to security protocols across the entire business as needed.

### 3. Independence

 Clients don't know how many layers exist. This gives teams the chance to add more layers in the future without breaking clients.

### 4. Fault Tolerance

 Even if a single layer has issues, there are ways to reroute traffic through unaffected routes until the faulting layer is fixed.