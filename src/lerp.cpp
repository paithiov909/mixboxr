#include "mixbox.h"
#include <cpp11.hpp>
#include <vector>
#include <tuple>

std::tuple<unsigned char, unsigned char, unsigned char, unsigned char>
int_to_rgba(uint32_t icol) {
  return std::make_tuple(icol & 0xFF, (icol >> 8) & 0xFF, (icol >> 16) & 0xFF,
                         (icol >> 24) & 0xFF);
}

uint32_t pack_into_int(unsigned char r, unsigned char g, unsigned char b,
                       unsigned char a) {
  return r | (g << 8) | (b << 16) | (a << 24);
}

[[cpp11::register]]
cpp11::integers lerp_cpp(cpp11::integers x, cpp11::integers y, const float t) {
  if (x.size() != y.size()) {
    cpp11::stop("x and y must be the same length");
  }
  std::vector<int> out(x.size());
  for (R_xlen_t i = 0; i < x.size(); i++) {
    const auto xi = int_to_rgba(x[i]);
    const auto yi = int_to_rgba(y[i]);
    unsigned char mix[3];
    mixbox_lerp(std::get<0>(xi), std::get<1>(xi), std::get<2>(xi),
                std::get<0>(yi), std::get<1>(yi), std::get<2>(yi), t, &mix[0],
                &mix[1], &mix[2]);
    out[i] = pack_into_int(mix[0], mix[1], mix[2],
                           std::get<3>(xi) | std::get<3>(yi));
  }
  return cpp11::as_sexp(out);
}
