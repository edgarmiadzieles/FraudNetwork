# FraudNetwork

There is a number of user accounts in the system. The accounts can be linked to each if a logical
connection exists between them. Furthermore, a malicious user account can be marked as
fraudulent.
Write a function/method get_fraud_score(user, links, fraudulent_users, depth) that computes
fraudulency score of a specific user account based on the provided link information.
The function takes the following parameters:
• user: a user to calculate the score for;
• links: a list of pairs of users, e.g. [{1, 5}, {5, 2}, {3, 1}]. The pairs are undirected, which
means that {1, 2} is the same as {2, 1};
• fraudulent_users: a list of users marked as fraudulent, e.g. [1, 3];
• depth: the maximum level of links to consider while traversing the link graph.
Initially, fraudulency score is 0. Each link with a fraudulent user adds an amount equal to (number
of direct links at the current level)/level to the score. No user is linked with themselves. Longer
circular links, e.g. 1 → 2 → 3 → 1 may freely exist, though.
Additionally, please cover the function with unit tests.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fraud_network` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fraud_network, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fraud_network](https://hexdocs.pm/fraud_network).

