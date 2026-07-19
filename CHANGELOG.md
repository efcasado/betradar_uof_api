## [1.1.0](https://github.com/efcasado/uof_api/compare/v1.0.5...v1.1.0) (2025-03-28)


### ✨ Features

* add age_group field to competitor model ([2e0c310](https://github.com/efcasado/uof_api/commit/2e0c3106f47407f257a08395da5b47665253b8ed))


### 📚 Documentation

* document usage of conventional commits ([6de2680](https://github.com/efcasado/uof_api/commit/6de2680f03382813fd13c9cf078062c4c43b5aaf))
* remove logo ([3904612](https://github.com/efcasado/uof_api/commit/3904612b8d5850b0d337b8d221423e2319e99a4a))

## [3.0.0](https://github.com/efcasado/betradar_uof_api/compare/v2.1.2...v3.0.0) (2026-07-19)


### ⚠ BREAKING CHANGES

* structured error handling ([#57](https://github.com/efcasado/betradar_uof_api/issues/57))

### Features

* add support for including mappings with market descriptions ([#61](https://github.com/efcasado/betradar_uof_api/issues/61)) ([f7d8ff3](https://github.com/efcasado/betradar_uof_api/commit/f7d8ff3aeb7d51dcaf8cc50af9f890fb368bfc58))
* add support for race_summary to summary/2 ([80e70b4](https://github.com/efcasado/betradar_uof_api/commit/80e70b4ae940a3b5331eb681058deebee66af07c))
* allow users to specify req options globally and per call ([#59](https://github.com/efcasado/betradar_uof_api/issues/59)) ([c19f5be](https://github.com/efcasado/betradar_uof_api/commit/c19f5be118a0de9f1126e51fc05f2b607a4cbe54))
* extend UOF.API.Sports.{fixture, result}_changes with after and sport filters ([#62](https://github.com/efcasado/betradar_uof_api/issues/62)) ([83e34b9](https://github.com/efcasado/betradar_uof_api/commit/83e34b94a425d0c13e1141cf572ec802f3bbd154))
* structured error handling ([#57](https://github.com/efcasado/betradar_uof_api/issues/57)) ([3127249](https://github.com/efcasado/betradar_uof_api/commit/312724985732cdb660416ccfcd6fe92110c5b5d0))


### Bug Fixes

* disable redirect to prevent token leak ([#60](https://github.com/efcasado/betradar_uof_api/issues/60)) ([bf1b7cb](https://github.com/efcasado/betradar_uof_api/commit/bf1b7cbe19bc377742704aaf732c9a0d587b87d5))


### Dependencies

* bump req from 0.6.2 to 0.6.3 ([#55](https://github.com/efcasado/betradar_uof_api/issues/55)) ([a655e17](https://github.com/efcasado/betradar_uof_api/commit/a655e178426772ab67a317ff752ef51783db898a))


### Miscellaneous Chores

* add styler ([#58](https://github.com/efcasado/betradar_uof_api/issues/58)) ([82d2090](https://github.com/efcasado/betradar_uof_api/commit/82d2090df115a455a8a26261465921a2b78e22b0))
* remove stale codds comment and add test ([82dc491](https://github.com/efcasado/betradar_uof_api/commit/82dc491c3fd869e45ff6b879099552c48602f748))

## [2.1.2](https://github.com/efcasado/betradar_uof_api/compare/v2.1.1...v2.1.2) (2026-07-14)


### Dependencies

* bump uof_schemas from 0.2.0 to 0.2.1 ([#53](https://github.com/efcasado/betradar_uof_api/issues/53)) ([d8a327e](https://github.com/efcasado/betradar_uof_api/commit/d8a327e6837c38fedb35f2733db07dc5d7e141d1))

## [2.1.1](https://github.com/efcasado/betradar_uof_api/compare/v2.1.0...v2.1.1) (2026-07-04)


### Bug Fixes

* data loss due to polymorphic responses ([#50](https://github.com/efcasado/betradar_uof_api/issues/50)) ([c81e166](https://github.com/efcasado/betradar_uof_api/commit/c81e1665ade840ab35f3b11fd99d475e89d164ac))

## [2.1.0](https://github.com/efcasado/betradar_uof_api/compare/v2.0.0...v2.1.0) (2026-06-24)


### Features

* re-use ecto schemas from uof_schemas library ([#46](https://github.com/efcasado/betradar_uof_api/issues/46)) ([6ed9d54](https://github.com/efcasado/betradar_uof_api/commit/6ed9d5437409e9ed7f6b941dc4d5c47105ba1597))


### Dependencies

* **ci:** bump actions/cache from 5 to 6 ([d239992](https://github.com/efcasado/betradar_uof_api/commit/d239992cf7a44b887be6e199f731e8d620bf8555))


### Tests

* coverage report using coveralls ([784e655](https://github.com/efcasado/betradar_uof_api/commit/784e6559ca37d2b99a5440f45926e9ba20f1ad3b))


### Miscellaneous Chores

* update readme ([4018c86](https://github.com/efcasado/betradar_uof_api/commit/4018c860910e64bc7a2d60eebed043e204cd48b0))

## [2.0.0](https://github.com/efcasado/uof_api/compare/v1.1.0...v2.0.0) (2026-06-20)


### ⚠ BREAKING CHANGES

* move auxiliary functions to a separate module and use streams
* generate schemas from xsd files

### Features

* ability to filter fixtures by booking state ([10d0378](https://github.com/efcasado/uof_api/commit/10d03785db40ff898b346f065c1e38a3d59448d6))
* add support for booking events ([2cf31e6](https://github.com/efcasado/uof_api/commit/2cf31e62c2b664e3168e892fa35de2b845d416c0))
* add support for fetching tournaments and seasons ([57adcb6](https://github.com/efcasado/uof_api/commit/57adcb695494fde03394f914056e2fd77bc1963e))
* add support for recovery api ([4fd2cf9](https://github.com/efcasado/uof_api/commit/4fd2cf969450c1d1dd4503d2a2cd5e7af2054053))
* generate schemas from xsd files ([64436b5](https://github.com/efcasado/uof_api/commit/64436b59ee13343ff9ca777b033755b05cabaf08))


### Dependencies

* bump ecto from 3.13.6 to 3.14.0 ([53e0617](https://github.com/efcasado/uof_api/commit/53e0617d6db2ffbee8071b3d9a76c0788c53e305))
* bump ex_doc from 0.32.1 to 0.40.3 ([4b10398](https://github.com/efcasado/uof_api/commit/4b103986f649264e9b8e959bb18351582727183d))
* bump mimic from 1.12.0 to 2.3.0 ([126b60e](https://github.com/efcasado/uof_api/commit/126b60e5dbdabecfdec5a9d32915b8a02ab08661))
* bump req from 0.4.14 to 0.6.2 ([f76b111](https://github.com/efcasado/uof_api/commit/f76b111673196a290972221ee0ff07ac4ef59e6b))
* bump saxy from 1.5.0 to 1.6.0 ([ef50884](https://github.com/efcasado/uof_api/commit/ef5088401da0a6a96f230d57ed89ffd171863178))
* bump xml_builder from 2.3.0 to 2.4.0 ([3e97fe8](https://github.com/efcasado/uof_api/commit/3e97fe8e450bc74a8b33b2a3f9cb822ba14584c7))
* **ci:** bump actions/cache from 4 to 5 ([ab3479d](https://github.com/efcasado/uof_api/commit/ab3479ded074a2da5138c367df845f56d6bbc939))
* **ci:** bump actions/checkout from 4 to 7 ([981beda](https://github.com/efcasado/uof_api/commit/981beda1e86b6ce6ccdf6c28349191961b7dd840))
* **ci:** bump jdx/mise-action from 2 to 4 ([aaec382](https://github.com/efcasado/uof_api/commit/aaec3821217d7a81a69ea273056c20ea09d90632))
* upgrade to erlang 29 and elixir 1.20 ([769dafa](https://github.com/efcasado/uof_api/commit/769dafa92f3e4fbc2f5d3029ac408015c6ff6c5c))


### Documentation

* add missing moduledocs for sports and descriptions modules ([b87fcb8](https://github.com/efcasado/uof_api/commit/b87fcb8b8b6b8b06943787762fb72e8c60868a66))
* fix typo ([886947d](https://github.com/efcasado/uof_api/commit/886947d9fe96890b439f29033b41f1ba82907668))
* improve documentation about generated schemas ([3da4f87](https://github.com/efcasado/uof_api/commit/3da4f873254db4e6d313235c7c5edff926d45d32))
* remove redundant custom bet example ([1dc7da7](https://github.com/efcasado/uof_api/commit/1dc7da72a798b5e6eb9d79fce83bc0dcb7e947ab))
* update readme ([8ec1b3c](https://github.com/efcasado/uof_api/commit/8ec1b3c0c8d772acf821393d6e50b5a4ee653d46))
* update readme file ([1f4907a](https://github.com/efcasado/uof_api/commit/1f4907aa13512ce5c3d1e40b096312a865c8d6e8))


### Code Refactoring

* idiomatic req usage ([2d0d2a5](https://github.com/efcasado/uof_api/commit/2d0d2a507e804f8daaf0ab348e4e8ef1571765e6))
* move auxiliary functions to a separate module and use streams ([473d1f4](https://github.com/efcasado/uof_api/commit/473d1f4a6b33ce531e73034e817ea6012ded2d2f))


### Build System

* reproducible builds powered by mise ([d1054ca](https://github.com/efcasado/uof_api/commit/d1054ca3457e3904428c732fe16715277777a2cc))


### Continuous Integration

* automate dependency upgrades with dependabot ([7e22e36](https://github.com/efcasado/uof_api/commit/7e22e36b4da7475d1a13f588e9475b5be38400a8))
* **release:** migrate from semantic-release to release-please ([2a08481](https://github.com/efcasado/uof_api/commit/2a084814e9560b5aeb426bf3e5dfabd335e4835d))
* remove vale's prose checking workflow ([2601c0e](https://github.com/efcasado/uof_api/commit/2601c0e90c3db8538775fec3e68557322518b6b7))

## [1.0.5](https://github.com/efcasado/uof_api/compare/v1.0.4...v1.0.5) (2024-05-09)


### 🛠 Builds

* limit workflow concurrency ([549d7ef](https://github.com/efcasado/uof_api/commit/549d7efb2a6b9e6eae50812af172e0e43a9a5eef))


### 📚 Documentation

* configure ex_docs ([d7570d8](https://github.com/efcasado/uof_api/commit/d7570d80ce1685cafab3ac19c06f8fdf79234418))


### ♻️ Chores

* add badges to README.md ([256f1cd](https://github.com/efcasado/uof_api/commit/256f1cdf1f5ac87ebb4e32e6ada0e6957dde099c))
* rename elixir workflow as build ([2e0bd60](https://github.com/efcasado/uof_api/commit/2e0bd60ccaae0a33eb1c1a044c964ad5f6fc7f9b))

## [1.0.4](https://github.com/efcasado/uof_api/compare/v1.0.3...v1.0.4) (2024-05-09)


### 🛠 Builds

* fix app name in mix.exs ([41ac325](https://github.com/efcasado/uof_api/commit/41ac3256a52b0714c63655c2337786e005296d30))

## [1.0.3](https://github.com/efcasado/uof_api/compare/v1.0.2...v1.0.3) (2024-05-09)


### 🛠 Builds

* enable publishing ([2c62485](https://github.com/efcasado/uof_api/commit/2c62485726fc16cde1408f41e227f7420813f195))
* fetch dependencies before publishing ([27e148c](https://github.com/efcasado/uof_api/commit/27e148c5a368ab30213ec9402a4309461b1b47e0))


### ♻️ Chores

* add hex.config to .gitignore ([ddb9456](https://github.com/efcasado/uof_api/commit/ddb94563253e6e52dcafaa68a437c4584562f2c0))

## [1.0.2](https://github.com/efcasado/uof_api/compare/v1.0.1...v1.0.2) (2024-05-09)


### 🛠 Builds

* fix release workflow ([74f6a26](https://github.com/efcasado/uof_api/commit/74f6a2669a69cd778c5d21e77847ee7a02541dab))
* update gh token used in release workflow ([e98701b](https://github.com/efcasado/uof_api/commit/e98701b0cd2d3fe78e6d1c7007c5b0ff221697be))

## [1.0.1](https://github.com/efcasado/uof_api/compare/v1.0.0...v1.0.1) (2024-05-09)


### 🛠 Builds

* automate publishing of hex package ([d403174](https://github.com/efcasado/uof_api/commit/d403174da6ca795083da744f49a6f83275c30754))
* remove unused env variables ([e56b861](https://github.com/efcasado/uof_api/commit/e56b861ed2bf6acc0656d4cb3364731c25c755a5))


### ♻️ Chores

* **ci:** introduce vale as linter for documentation ([373110d](https://github.com/efcasado/uof_api/commit/373110db434e7a7d6fa07c58b44e9eee7b8df532))
* **docs:** add basic example to README.md ([05dc6b5](https://github.com/efcasado/uof_api/commit/05dc6b5bb544d7a0225c17f2a8708b7b8f1f4270))
* **docs:** fix typo in README.md ([480fe7f](https://github.com/efcasado/uof_api/commit/480fe7f5c9881b232b35d026af2e279e1e22cff6))
* **docs:** improve examples ([695e49b](https://github.com/efcasado/uof_api/commit/695e49bb34dbe533fe9c1bdf79660d3aa7c8808c))
* **docs:** update README.md ([070ea17](https://github.com/efcasado/uof_api/commit/070ea17c6d8d480c787196eac58538c86f4510fd))

## 1.0.0 (2024-05-07)


### ⚠ Breaking changes

* adjust directory structure

### ✨ Features

* ability to toggle parsing of response body ([34322ed](https://github.com/efcasado/uof_api/commit/34322ed978e5fd1a7286e3807ca934c7ae958cf3))
* add 'all_sports' and 'period_number' to match_status ([c932ad3](https://github.com/efcasado/uof_api/commit/c932ad35a7baee9979f38f14ab0004ec82fde296))
* add auxiliary functions ([785ec40](https://github.com/efcasado/uof_api/commit/785ec4038bf1684cc7df187d564b37be02bcfa07))
* add more endpoints ([e9cad8c](https://github.com/efcasado/uof_api/commit/e9cad8cbb180fa3328407da8d335763371e8c057))
* add more endpoints ([58a0d09](https://github.com/efcasado/uof_api/commit/58a0d093e29c85a2dfaac021d6f7837cb9783f01))
* add support for custombet api ([f2490ef](https://github.com/efcasado/uof_api/commit/f2490efb357a04a9452d95e9afb777642243d90d))
* add support for probability api ([7afd1ad](https://github.com/efcasado/uof_api/commit/7afd1ad7611e47936cff28679e9399bcabc038f5))
* add tests for mappings ([78b7860](https://github.com/efcasado/uof_api/commit/78b786091a0e9a4a2731de47bd392e48c1933d93))
* add tests for mappings ([bedc3c2](https://github.com/efcasado/uof_api/commit/bedc3c2eeb9c8446fcadb0a7cc2b4503b0554e03))
* add tests for mappings ([2bf0e87](https://github.com/efcasado/uof_api/commit/2bf0e87725ffd0eda025fa741509a2c178ce1881))
* add tests for mappings ([5e9ac10](https://github.com/efcasado/uof_api/commit/5e9ac100e59a73947333d60acfbe6f72dbb72959))
* add tests for mappings ([0bbb1fd](https://github.com/efcasado/uof_api/commit/0bbb1fda00e55859417187d15f252c43dcf71f5c))
* add tests for mappings ([f76a76c](https://github.com/efcasado/uof_api/commit/f76a76c56a5602160fd698eaf7bf8d6d7cccd254))
* add tests for mappings ([b62cf1c](https://github.com/efcasado/uof_api/commit/b62cf1ce561e8cb5ab6d05110cc51bde1de4c4e7))
* add tests for mappings ([6d93eb0](https://github.com/efcasado/uof_api/commit/6d93eb02f1643d1becf23d43db8953f5aa5e5274))
* add tests for mappings ([9c7a306](https://github.com/efcasado/uof_api/commit/9c7a306dc4de2a87feebae1649670eab002658a6))
* add tests for mappings ([6c3890d](https://github.com/efcasado/uof_api/commit/6c3890d4735025bab02e6c2b382c8846e7a65fa2))
* add tests for mappings ([39bbbfa](https://github.com/efcasado/uof_api/commit/39bbbfa71f95d35049e78b86999a92a3c1d859ae))
* add tests for mappings ([9ab50cc](https://github.com/efcasado/uof_api/commit/9ab50cc817afa3f280e7d61eb380b736c2bd839e))
* add UOF.API.timeline/{1, 2} ([6848982](https://github.com/efcasado/uof_api/commit/68489823133e8204c83a74b665d3362791912bf2))
* add UOF.API.variants/{0, 1} ([5cac1bc](https://github.com/efcasado/uof_api/commit/5cac1bc435c21884e2a9c8d98a2afe647b1db1b0))
* replace sweetxml by saxaboom ([544e841](https://github.com/efcasado/uof_api/commit/544e841f1b0f21d17bcf46c5eda5d57daea8d587))


### 🐛 Bug Fixes

* cannot parse tournaments without season ([d04196b](https://github.com/efcasado/uof_api/commit/d04196bd087d8398656f41f9ca4129f5277c5e05))
* cast market and outcome ids to integer ([5243262](https://github.com/efcasado/uof_api/commit/52432620f9751ee4d90b280ad71803af74d8983e))
* casting and parsing of fixture properties ([4370f68](https://github.com/efcasado/uof_api/commit/4370f68d01bbaf0ccccb3541b671033c62047677))
* code re-usability ([#1](https://github.com/efcasado/uof_api/issues/1)) ([da02f21](https://github.com/efcasado/uof_api/commit/da02f213476a1bd90d2d7b67657715e363cc02b9))
* include coverage_info in torunament element ([8a3467a](https://github.com/efcasado/uof_api/commit/8a3467ae0f2df1d55aea303c492558c81b945b80))
* incomplete competitor profile response ([05fff4b](https://github.com/efcasado/uof_api/commit/05fff4b01b92670c68c7559903ea2bbe4bffc74b))
* incomplete sport categories response ([b865dde](https://github.com/efcasado/uof_api/commit/b865ddec016a84a1d0a1f7f0ac18c5f9cf18d8c0))
* incomplete sport tournaments response ([0bb69a1](https://github.com/efcasado/uof_api/commit/0bb69a1b76d1999b16e309e9a78260ccf513e8e2))
* incomplete summary response ([7521e08](https://github.com/efcasado/uof_api/commit/7521e08d9c1c6687b08e4cbaba55b7ddb84c3798))
* incomplete tournament info response ([c18d4a8](https://github.com/efcasado/uof_api/commit/c18d4a8ed1d09170083662b501b7b2a16d2246cf))
* parse competitors included in tournament element ([8439aef](https://github.com/efcasado/uof_api/commit/8439aef21c6de059148e9300d18f88137af26910))


### ♻️ Chores

* add badge to README ([5b5041e](https://github.com/efcasado/uof_api/commit/5b5041ef716bf7f26bac41adacef4be708148ef4))
* add custom bet example ([c369f9e](https://github.com/efcasado/uof_api/commit/c369f9e8005c08c6cf4766e1683266dd72127c4b))
* adjust directory structure ([b3de155](https://github.com/efcasado/uof_api/commit/b3de15553cff698f8a39066438ab685589e19cb1))
* automate releases with semantic-release ([4f19ba6](https://github.com/efcasado/uof_api/commit/4f19ba6f9124fbd4b5e60db1476b2db9798c73fb))
* change gha workflow name ([0f31cc2](https://github.com/efcasado/uof_api/commit/0f31cc2f2eb98b0b687416f7790a4e13498d25e7))
* ci badge reports status on main branch ([e441faa](https://github.com/efcasado/uof_api/commit/e441faaf33ca2f88311cc2821ca2093d7754a25b))
* **ci:** adjust workflow permissions ([cb112ee](https://github.com/efcasado/uof_api/commit/cb112ee10fce3cdc5c0feba2bfa5dc1a10ede143))
* **ci:** bootstrap gha pipeline ([d02b951](https://github.com/efcasado/uof_api/commit/d02b951fb9a9b61720cd566058f6ef019880340c))
* **ci:** deprecated Node 16 warnings ([953f352](https://github.com/efcasado/uof_api/commit/953f352e5ac7d0c23d3d06211a92540bd6222762))
* **ci:** disable dry-run mode ([5d24118](https://github.com/efcasado/uof_api/commit/5d24118790bd71bbcd7fd04b09ebc5e19f175e9b))
* **ci:** fix configuration of release workflow ([24056a3](https://github.com/efcasado/uof_api/commit/24056a3ab5859b74e278f71f16defaa3cbabc180))
* comment out non-implemented functions ([5b003b5](https://github.com/efcasado/uof_api/commit/5b003b536dad72b550fd74a026afcacac17a81e8))
* **docs:** add example to README.md ([c80470c](https://github.com/efcasado/uof_api/commit/c80470c54f4f805f380cab924dbc5264da433c56))
* **docs:** add module docs ([56523d8](https://github.com/efcasado/uof_api/commit/56523d8496bb74391967af67baa6ba46340cc395))
* **docs:** hide non-documented modules ([1d11c4c](https://github.com/efcasado/uof_api/commit/1d11c4cec9086f8ae1bd563bbf39f650b56d5fc0))
* **docs:** update README.md ([a14cad3](https://github.com/efcasado/uof_api/commit/a14cad3874ffe93b5e977bf295bdbd849172a9d7))
* fix directory structure of utils modules ([9685704](https://github.com/efcasado/uof_api/commit/96857042ce1c23bdaab716a38a7251ec069c74e1))
* fix formatting ([4901790](https://github.com/efcasado/uof_api/commit/49017900a5328059172adb87c9345134f2d221ef))
* initial commit ([acc8c00](https://github.com/efcasado/uof_api/commit/acc8c0081145bf04b8cb101aa83077913c0fb619))
* **logs:** log http response body at debug level ([30a1d1a](https://github.com/efcasado/uof_api/commit/30a1d1ac46cbaddc4e63784f2ffe1e492cfb42e0))
* pretty print test data files ([7963466](https://github.com/efcasado/uof_api/commit/7963466f0329425fad1876d09a90281155efcfd8))
* remove unnecessary config file ([5110eb2](https://github.com/efcasado/uof_api/commit/5110eb2db54900fb54daba7053ec795a4257125b))
* **test:** can parse UOF.API.whoami/0 response ([8144ad2](https://github.com/efcasado/uof_api/commit/8144ad21ef93f8f95d72cf7fc7f4858cd1cab3a8))
* **test:** run doctests ([b406876](https://github.com/efcasado/uof_api/commit/b406876d6d4f61ede997bdbf9e6d3c99a91dd7ed))
* **tests:** add more tests ([80505fc](https://github.com/efcasado/uof_api/commit/80505fcbb299c9b16cd6ceea1435c9b2ab9180ee))
* **tests:** add tests for UOF.API.tournament/1 ([0603785](https://github.com/efcasado/uof_api/commit/0603785eb7d3d3ea283244dc7dce63b4fa0f134d))
* **tests:** mock http requests ([c77260f](https://github.com/efcasado/uof_api/commit/c77260fc84e242e09ff907269ebb7c86cb34002e))
* update ci badge ([b68ff79](https://github.com/efcasado/uof_api/commit/b68ff7942dda04e71108114e9efd5a4b0fd15b1d))
* update logo ([b7ecb83](https://github.com/efcasado/uof_api/commit/b7ecb839e15bc9f3591620acb43af6686ceff377))
* update README.md ([5023f31](https://github.com/efcasado/uof_api/commit/5023f31acad18f276afd352935a1f766fd7682da))
* update README.md ([297c93d](https://github.com/efcasado/uof_api/commit/297c93dfc3fc9bcdabf401a1ad94a7e510de27fa))
* update README.md ([1f837b9](https://github.com/efcasado/uof_api/commit/1f837b92fb850d81dff85619c04d3d002036a428))
* update README.md ([9af18c1](https://github.com/efcasado/uof_api/commit/9af18c185f7e8a7c07a688fb26cdaf8925bc9498))
