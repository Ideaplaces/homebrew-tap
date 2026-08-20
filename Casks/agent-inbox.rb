cask "agent-inbox" do
  version "0.1.1"
  sha256 "016d2ea147ef1d1770d86fd7ddffde8bc3d9dba6698449fb39f001e71812ed99"

  url "https://github.com/Ideaplaces/agent-inbox/releases/download/v#{version}/AgentInbox-#{version}.dmg",
      verified: "github.com/Ideaplaces/agent-inbox/"
  name "Agent Inbox"
  desc "Native notifications for every Claude Code session that finishes or needs you"
  homepage "https://github.com/Ideaplaces/agent-inbox"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Agent Inbox.app"

  uninstall quit: "com.ideaplaces.agent-inbox"

  # The hooks in ~/.claude/settings.json and the unpacked notify.sh are removed
  # from the app's own Settings, not here: they keep working without the app,
  # which is the point of putting them outside the bundle.
  zap trash: [
    "~/Library/Preferences/com.ideaplaces.agent-inbox.plist",
    "~/Library/Caches/com.ideaplaces.agent-inbox",
  ]
end
