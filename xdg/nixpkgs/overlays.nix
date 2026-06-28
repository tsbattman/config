[
  (self: super: {
    youtube-dl = super.python3.pkgs.callPackage ./youtube-dl { };
  })
  # (self: super: {
  #   claude-code = super.claude-code.override (oldArgs: {
  #     version = "2.1.19";
  #     src = super.fetchzip {
  #       url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
  #       hash = "";
  #     };
  #   });
  # })
]
