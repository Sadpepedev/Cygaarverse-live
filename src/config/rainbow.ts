import { connectorsForWallets } from "@rainbow-me/rainbowkit";
import { abstractWallet } from "@abstract-foundation/agw-react/connectors";

export const connectors = connectorsForWallets(
  [
    {
      groupName: "Abstract",
      wallets: [abstractWallet],
    },
  ],
  {
    appName: "Cygaar Points Tracker",
    projectId: "cygaar-points",
    appDescription: "Track your points earned from holding Cygaar tokens",
    appUrl: "https://points.cygaar.dev",
  }
);