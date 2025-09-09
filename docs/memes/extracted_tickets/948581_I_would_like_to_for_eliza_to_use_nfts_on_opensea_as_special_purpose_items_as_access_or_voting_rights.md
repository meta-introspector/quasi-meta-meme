# I would like to for eliza to use nfts on opensea as special purpose items as access or voting rights

**ID:** 948581
**Created At:** 2025-01-15T11:56:11+00:00
**Source:** https://codeberg.org/introspector/meta-meme/issues/49

---

Join Discord
I would like to for eliza to use nfts on opensea as special purpose items as access or voting rights
Based on the community discussions and feature requests, I can help explain how NFTs are being integrated into the Eliza ecosystem.

Several community members have expressed interest in NFT functionality, particularly for access rights and governance. [chat_2024-12-07] shows there's already discussion about NFT implementation and trading aspects.

The community is actively working on several NFT-related features:

Special Access Channels: There are plans to create dedicated channels and roles for NFT holders [chat_2024-12-09]

Interactive Elements: There's development happening around 3D AI agents using elizaos models, where NFT holders would get special customization rights [chat_2024-11-07]

Gaming Integration: Some members are working on integrating elizaos VRM models into platforms like Nifty Island, which could provide NFT holders with special access and capabilities [chat_2024-10-28]

For implementing NFTs with special purposes, you can:

Create token-gated spaces for exclusive access
Set up voting mechanisms tied to NFT ownership
Establish different tiers of access based on NFT holdings
Enable customization rights for NFT holders
The community is actively developing these features, and there's strong support for expanding NFT utility within the ecosystem.


15 sources
validateCharacterConfig
chat_2024-12-07
chat_2024-12-09
chat_2024-12-09
faq-and-support
Action
chat_2024-11-07
chat_2024-11-22
chat_2024-11-20
chat_2024-11-20
chat_2024-12-04
chat_2024-12-04
chat_2024-10-28
faq-and-support
Comment on Issue #985

How can I integrate OpenSea NFT ownership verification with Eliza agents to grant special access privileges?

What types of voting mechanisms can be implemented using NFT-based governance for Eliza agents?

Can NFT holders get special interaction capabilities or commands when communicating with Eliza agents?
can you see this https://opensea.io/assets/base/0x0f4a030f9286ad80e36cd77636df8c7940c9c1b7/1/
I apologize, but I cannot directly access or view external links in real-time. I cannot verify or see the specific OpenSea NFT you're trying to share.

To help you better, you could:

Share the relevant details about the NFT you're interested in (like collection name, properties, utilities)

Describe what specific functionality you're trying to implement with this NFT

Explain your use case for integrating it with Eliza

This way, I can provide more specific guidance on how to implement NFT functionality within the Eliza framework [providers] and help you with the integration process.


15 sources

How can I verify if this NFT collection is authentic and verified on OpenSea?

What are the trading statistics and price history for this NFT on Base network?

Can I transfer this NFT to other blockchain networks or is it locked to Base?
well it is on base, so what plugins would let me check the properties of this base contract and instance
For interacting with NFTs on Base network, you can use the Coinbase Token Contract Plugin which has built-in support for Base network interactions. [plugins]

Here's how you can check the properties of an NFT contract on Base:

typescript

1
2
3
4
5
6
7
8
⌄
⌄
const response = await runtime.triggerAction("INVOKE_CONTRACT", {
  contractAddress: "0x0f4a030f9286ad80e36cd77636df8c7940c9c1b7",
  method: "tokenURI",
  args: {
    tokenId: "1"
  },
  network: "base"
});
You can also use the plugin to check other standard NFT properties like:

Owner information
Token metadata
Transfer history
Contract permissions
The Coinbase Token Contract Plugin [plugins] supports:

ERC721 standard NFT interactions
Metadata URI retrieval
Contract state queries
Owner verification
Make sure you have configured the necessary environment variables:

COINBASE_API_KEY
COINBASE_PRIVATE_KEY
This will allow you to interact with any NFT contract on the Base network and retrieve its properties and metadata.


15 sources

How can I use the Coinbase Token Contract plugin to interact with and check the properties of my existing contract on Base?

What specific contract methods can I call using the INVOKE_CONTRACT action to view token properties like total supply and balances?

Are there any security considerations or best practices I should follow when querying contract data on Base using these plugins?
so now we want to create an authentication plugin for the website to check if you have this much in your wallet of that nft to access it.
I can help you create an authentication plugin for NFT-based website access. Here's how you can implement this using Eliza's plugin system:

typescript

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
⌄
⌄
⌄
⌄
⌄
⌄
⌄
import { coinbaseMassPaymentsPlugin } from "@eliza/plugin-coinbase-masspayments";

const nftAuthPlugin = {
    name: 'nft-auth-plugin',
    init: async (runtime) => {
        // Configure the plugin with your NFT contract details
        const NFT_CONTRACT = "0x0f4a030f9286ad80e36cd77636df8c7940c9c1b7";
        const REQUIRED_BALANCE = 1; // Minimum NFTs required for access

        // Add authentication evaluator
        runtime.addEvaluator({
            name: 'check-nft-balance',
            evaluate: async (context) => {
                const { walletAddress } = context;
                
                // Check NFT balance
                const balance = await runtime.triggerAction("GET_NFT_BALANCE", {
                    contractAddress: NFT_CONTRACT,
                    walletAddress,
                    network: "base"
                });

                return balance >= REQUIRED_BALANCE;
            }
        });
    }
};

// Add to your character configuration
const character = {
    plugins: [
        coinbaseMassPaymentsPlugin,
        nftAuthPlugin
    ]
};
To implement this in your website authentication flow [plugins]:

typescript

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
⌄
⌄
⌄
⌄
// Example authentication middleware
async function authMiddleware(req, res, next) {
    const walletAddress = req.headers['wallet-address'];
    
    const isAuthenticated = await runtime.evaluate('check-nft-balance', {
        walletAddress
    });

    if (!isAuthenticated) {
        return res.status(401).json({
            error: 'Insufficient NFT balance for access'
        });
    }

    next();
}
This implementation:

Verifies NFT ownership on the Base network
Checks if the wallet meets the minimum balance requirement
Can be easily integrated with web frameworks
Supports wallet connection via Coinbase Wallet [plugins]
The plugin can be extended to include additional features like:

Caching results to reduce RPC calls
Multiple NFT contract support
Tiered access levels based on NFT count
Token-gated API endpoints

15 sources

How can I integrate the Coinbase wallet plugin with the authentication system to verify NFT holdings?

What's the best way to set up different access levels based on the amount of tokens or specific NFTs in a user's wallet?

Can you show me an example of how to implement wallet connection and token balance checking in the authentication plugin?