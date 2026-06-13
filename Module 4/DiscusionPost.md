# Session Beans
## What are session Beans?
According to Oracle documentation, this is what session beans are:
"Session beans implement business logic. A session bean instance serves one client at a time. There are two types of session beans: stateful and stateless."

For those that are more familiar with .Net terminology, session beans are similar to the concept of a service in .Net. They are used to encapsulate business logic and can be either stateful or stateless, depending on whether they maintain state across method calls.

## How would we use a session Bean?

Session beans are typically used in enterprise applications to handle business logic and transactions. They can be invoked by clients, such as web applications or other enterprise components, to perform specific tasks. For example, a session bean could be used to manage user authentication, process orders, or handle financial transactions. The choice between stateful and stateless session beans depends on the specific requirements of the application. Stateless session beans are typically used for tasks that do not require maintaining state across method calls, while stateful session beans are used when there is a need to maintain state information for a client across multiple method calls.

Here is an example of how to use a stateless session bean in Java:

``` java
import javax.ejb.Stateless;
@Stateless
public class MyStatelessBean {
    public String sayHello(String name) {
        return "Hello, " + name + "!";
    }
}
```
In this example, we have defined a stateless session bean called `MyStatelessBean` with a method `sayHello` that takes a string parameter and returns a greeting message. This bean can be invoked by clients to get a personalized greeting without maintaining any state information between calls.


## Why would we use a session Bean?
You would use a session bean to encapsulate business logic in an enterprise application. Session beans provide a way to manage transactions, security, and concurrency in a scalable and efficient manner. They allow you to separate business logic from presentation and data access layers, making your application more modular and easier to maintain. Additionally, session beans can be easily accessed by clients, such as web applications or other enterprise components, which makes them a convenient choice for implementing business logic in a distributed environment.

## Reference:

Understanding Enterprise JavaBeans. (2026). Oracle.com. https://docs.oracle.com/middleware/12213/wls/EJBPG/understanding.htm#EJBPG120

‌