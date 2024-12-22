class CyrusSaslXoauth2 < Formula
  env :std
  desc "XOAuth2 plugin for cyrus-sasl"
  homepage "https://github.com/moriyoshi/cyrus-sasl-xoauth2"
  license "MIT"
  url "https://github.com/moriyoshi/cyrus-sasl-xoauth2/archive/refs/tags/v0.2.tar.gz"
  head "https://github.com/moriyoshi/cyrus-sasl-xoauth2.git"

  depends_on "cyrus-sasl"
  depends_on "gnu-sed" => :build
  depends_on "libtool" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    cyrus_sasl = Formula["cyrus-sasl"]
    system "gsed", "-i", "s/libtoolize/glibtoolize/g", "autogen.sh"
    system "./autogen.sh"
    system "./configure",
      "--with-cyrus-sasl=/opt/homebrew/opt/cyrus-sasl",
      *std_configure_args
    system "make"
    system "install", "-c", ".libs/libxoauth2.0.so", "#{prefix}"
    ohai "Remember to link the xoauth2 plugin for cyrus-sasl to pick it up!"
    ohai "ln -s #{prefix}/libxoauth2.0.so /opt/homebrew/opt/cyrus-sasl/lib/sasl2"
  end
end
