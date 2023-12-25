# StarGate Discovery Network (SGDN) V1
Requests are served via rednet on the protocol "SGDN". All implementations must specify and check version numbers to ensure forward compatibility. If a server receives a message with an unsupported version, it must respond with an empty message specifying it's version.
## Request
```json
{
    "version": 1,
    "direction": "server"
}
```
- version: 1, The current version
- direction: "client", Specifies that this is serverbound
## Response
```json
{
    "version": 1,
    "direction": "client",
    "gates": [
        {
            "group": "examplegroup",
            "identifier": "example",
            "name": "Example Stargate",
            "address": [1,2,3,4,5,6,7,8,0],
            "extensions": []
        }
    ]
}
```
- version: 1, The current version
- direction: "client", Specifies that this is clientbound
- gates: [ Stargate ], An array of stargates, can
be nil if there were incompatible versions
## Stargate
```json
{
    "group": "examplegroup",
    "identifier": "example",
    "name": "Example Stargate",
    "address": [1,2,3,4,5,6,7,8,0],
    "extensions": []
}
```
- group: Kind of like a TLD (.com, .net). Specifies a central authority for the gate. Only lowercase alphanumeric
- identifier: kind of like a domain name (www.google, www.minecraft). Specifies a group-unique, (optionally) self-descriptive identifier for the gate. lowercase Alphanumeric + "." only.
- name: a human friendly gate name. not unique.
- address: an array of symbols, ending with a 0. Clients definitely should validate this.
- extensions[ Extension ]: an array specifying a list of Extensions and their data.
## Extensions
Extensions allow for adding additional information to the SGDN.
Extensions specific to a mod should be namespaced to help prevent confusion.
## Core Extensions
Core extensions are extensions officially specified by this standard. It is highly recommended that all servers implement these.
### Position
An array specifying the gate's position
```json
{
    "name": "position",
    "data": {x, y, z}
}
```
### Dimension
An string specifying the gate's dimension
```json
{
    "name": "dimension",
    "data": "namespace:dimension"
}
```
### Short Identifier
A quickly typeable identifier (think: single character) for use in command line interfaces. Unique within groups 
Cannot be: "q", "z", "n", "p", "-", or "+". Also cannot include ":"
```json
{
    "name": "short_identifier",
    "data": "a"
}
```
