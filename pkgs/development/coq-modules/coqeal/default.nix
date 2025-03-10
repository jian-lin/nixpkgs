{ coq, mkCoqDerivation, mathcomp, bignums, paramcoq, multinomials,
  mathcomp-real-closed,
  lib, which, version ? null }:

with lib;

(mkCoqDerivation {

  pname = "CoqEAL";

  inherit version;
  defaultVersion = with versions; switch [ coq.version mathcomp.version ]  [
      { cases = [ (isGe "8.10") (isGe "1.12.0") ]; out = "1.0.6"; }
      { cases = [ (isGe "8.10") (range "1.11.0" "1.12.0") ]; out = "1.0.5"; }
      { cases = [ (isGe "8.7") "1.11.0" ]; out = "1.0.4"; }
      { cases = [ (isGe "8.7") "1.10.0" ]; out = "1.0.3"; }
    ] null;

  release."1.0.6".sha256 = "0lqkyfj4qbq8wr3yk8qgn7mclw582n3fjl9l19yp8cnchspzywx0";
  release."1.0.5".sha256 = "0cmvky8glb5z2dy3q62aln6qbav4lrf2q1589f6h1gn5bgjrbzkm";
  release."1.0.4".sha256 = "1g5m26lr2lwxh6ld2gykailhay4d0ayql4bfh0aiwqpmmczmxipk";
  release."1.0.3".sha256 = "0hc63ny7phzbihy8l7wxjvn3haxx8jfnhi91iw8hkq8n29i23v24";

  extraBuildInputs = [ which ];
  propagatedBuildInputs = [ mathcomp.algebra bignums paramcoq multinomials ];

  meta = {
    description = "CoqEAL - The Coq Effective Algebra Library";
    license = licenses.mit;
  };
}).overrideAttrs (o: {
  propagatedBuildInputs = o.propagatedBuildInputs
  ++ optional (versions.isGe "1.1" o.version || o.version == "dev") mathcomp-real-closed;
})
