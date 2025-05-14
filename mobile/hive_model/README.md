hive_generator and riverpod_generator are incompatible with each other.
So we have to split hive model code into a separate package.

The following errors were encountered when trying to run `flutter pub get`:

```shell
Because no versions of hive_generator match >2.0.1 <3.0.0 and hive_generator 2.0.1 depends on source_gen ^1.0.0, hive_generator ^2.0.1
  requires source_gen ^1.0.0.
And because riverpod_generator 2.6.5 depends on source_gen ^2.0.0 and no versions of riverpod_generator match >2.6.5 <3.0.0,
  hive_generator ^2.0.1 is incompatible with riverpod_generator ^2.6.5.
So, because diarlies depends on both riverpod_generator ^2.6.5 and hive_generator ^2.0.1, version solving failed.
```

```shell
Because no versions of hive_generator match >2.0.1 <3.0.0 and hive_generator 2.0.1 depends on analyzer >=4.6.0 <7.0.0, hive_generator
  ^2.0.1 requires analyzer >=4.6.0 <7.0.0.
And because riverpod_generator 2.6.5 depends on analyzer ^7.0.0 and no versions of riverpod_generator match >2.6.5 <3.0.0,
  hive_generator ^2.0.1 is incompatible with riverpod_generator ^2.6.5.
So, because diarlies depends on both riverpod_generator ^2.6.5 and hive_generator ^2.0.1, version solving failed.
```