class CyrusSaslXoauth2 < Formula
  env :std
  desc "XOAuth2 plugin for cyrus-sasl"
  homepage "https://github.com/moriyoshi/cyrus-sasl-xoauth2"
  url "https://github.com/moriyoshi/cyrus-sasl-xoauth2/archive/refs/tags/v0.2.tar.gz"
  sha256 "a62c26566098100d30aa254e4c1aa4309876b470f139e1019bb9032b6e2ee943"
  license "MIT"
  head "https://github.com/moriyoshi/cyrus-sasl-xoauth2.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gnu-sed" => :build
  depends_on "libtool" => :build
  depends_on "cyrus-sasl"

  def install
    system "gsed", "-i", "s/libtoolize/glibtoolize/g", "autogen.sh"
    system "./autogen.sh"
    system "./configure",
      "--with-cyrus-sasl=/opt/homebrew/opt/cyrus-sasl",
      *std_configure_args
    system "make"
    lib.install ".libs/libxoauth2.0.so"
    ohai "Remember to link the xoauth2 plugin for cyrus-sasl to pick it up!"
    ohai "ln -s #{lib}/libxoauth2.0.so #{HOMEBREW_PREFIX}/opt/cyrus-sasl/lib/sasl2"
  end
end
