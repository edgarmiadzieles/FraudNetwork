# FraudNetwork

#### Task:

There is a number of user accounts in the system. The accounts can be linked to each if a logical
connection exists between them. Furthermore, a malicious user account can be marked as
fraudulent.
Write a function/method get_fraud_score(user, links, fraudulent_users, depth) that computes
fraudulency score of a specific user account based on the provided link information.
The function takes the following parameters:

* user: a user to calculate the score for
* links: a list of pairs of users, e.g. [{1, 5}, {5, 2}, {3, 1}]. The pairs are undirected, which
means that {1, 2} is the same as {2, 1}
* fraudulent_users: a list of users marked as fraudulent, e.g. [1, 3];
* depth: the maximum level of links to consider while traversing the link graph.

Initially, fraudulency score is 0. Each link with a fraudulent user adds an amount equal to (number
of direct links at the current level)/level to the score. No user is linked with themselves. Longer
circular links, e.g. 1 → 2 → 3 → 1 may freely exist, though.
Additionally, please cover the function with unit tests.

#### Interpretation
Starting with fraudulent user will give an error.
Starting with non existent user will give an error.
No node is considered twice. That means that a loop like 1 -> 2 -> 3 -> 1 will stop at 3 (before last 1).
That means that one a node has been used for score calculation it wont be used again.
Level - current node and it's conneciton.
Depth - Current depth with all the nodes (levels)


#### Running the app
App is written in elixir.
Base generated with mix and all the tests can be run with ```mix test```.
