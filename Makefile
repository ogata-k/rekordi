clean:
	fvm flutter clean

test:
	fvm flutter test

upgrade-package:
	fvm flutter  --no-color pub upgrade
	fvm flutter pub

build-dev:
	fvm flutter run --flavor develop

build-stg:
	fvm flutter run --flavor staging --release

build-prod:
	fvm flutter run --flavor production --release

gen-l10n:
	fvm flutter gen-l10n

gen:
	fvm dart run build_runner build --delete-conflicting-outputs

gen-watch:
	fvm dart run build_runner build watch --delete-conflicting-outputs

gen-all:
	fvm flutter gen-l10n
	fvm dart run build_runner build --delete-conflicting-outputs