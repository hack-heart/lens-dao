# Lens DAO

Lens DAO is a factory contract for building DAOs whose governance token is a FollowNFT from Lens Protocol.
It uses OpenZeppelin's IGovernor interface since it's battle-tested, but replaces IVotes with the Lens Protocol FollowNFT's built-in capabilities.

## V0.0.1
Version 0.0.1 was created at the DAOHacks hackathon and only lays the foundation for several capabilities. In particular, many values
are hardcoded, e.g the Governor name, the required quorum, among others. These will be made customisable once a frontend is built out to allow for inputing those values. In addition, several Lens Protocol frontends have already been built out that allow us to create profiles, and since the Governor contract is based on Open Zeppelin Governor, we can use Tally to manage a created DAO, and it suffices for the current contract capabilities.

### TODOS:
1. Storage for DAO lookup by profileID, NFTtokenAddress, name, and a unique identifier to be generated (perhaps a combination of creator, nft, and block.number)
2. Improved error handling
3. Customisable parameters
4. Security
5. GraphQL indexing for governance details, searching for DAOs, proposals, etc

### Current Limitations:
Anyone can spin up a DAO for any profile, and multiple DAOs for the same profile can be created. This is intentional for now and will be considered for change in future versions. The current reasons for this inlcude the following:
1. Changing parameters in the future, e.g quorum
2. Fan-made DAOs for creators
3. The ability for profiles to redefine their organisation, reset parameters, and generally unassociate themselves with the executions of a previous DAO.
4. The ability for creators to create different types of DAOs e.g a DAO with a great treasury whose proposal parameters are stricter and one with a smaller one for their general following

These are just ideas! It's very exciting what we can build on Lens.

## The Frontend
The frontend only includes options to connect an ethereum wallet and to spin up a DAO for an address (mostly because of limited time, and neither the code nor the UI is cleaned up. A full-fledged frontend is a priority for the future).

We can create a profile on lenster.xyz, and view our DAO on Tally. We can also use Remix to check our voting power at a block.

Network: Polygon Mumbai

Deployed Contracts:
Governor Implementation deployed to: 0x28332D11AA0a1A7c40Eb0C37B102EA2ce91af1Ea
TimelockControl Implementation deployed to: 0x600C482F704b0D03f050Fb546e744FF6929D3503
GovernorFactory deployed to: 0x9d5A7af6eA260a0ba410CD263d717d20B89A4eb1