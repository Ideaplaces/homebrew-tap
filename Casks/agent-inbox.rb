cask "agent-inbox" do
  version "0.1.6"
  sha256 "7edd4613248c4ec9e089ecd3fb9d75955f91d8f065712d2e79ba4d65357b87f7"

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
