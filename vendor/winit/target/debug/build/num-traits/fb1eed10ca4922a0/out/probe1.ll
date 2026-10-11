; ModuleID = 'probe1.fa99c6c9405c2868-cgu.0'
source_filename = "probe1.fa99c6c9405c2868-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@alloc_f93507f8ba4b5780b14b2c2584609be0 = private unnamed_addr constant [8 x i8] c"\00\00\00\00\00\00\F0?", align 8, !guid !0
@alloc_ef0a1f828f3393ef691f2705e817091c = private unnamed_addr constant [8 x i8] c"\00\00\00\00\00\00\00@", align 8, !guid !1

; probe1::probe
; Function Attrs: nonlazybind uwtable
define void @_RNvCslvWntd2Wrzg_6probe15probe() unnamed_addr #0 !guid !6 {
start:
; call <f64>::total_cmp
  %_1 = call i8 @_RNvMNtCs2GUV5EsPSwH_4core3f64d9total_cmpCslvWntd2Wrzg_6probe1(ptr align 8 @alloc_f93507f8ba4b5780b14b2c2584609be0, ptr align 8 @alloc_ef0a1f828f3393ef691f2705e817091c)
  ret void
}

; <f64>::total_cmp
; Function Attrs: inlinehint nonlazybind uwtable
define internal i8 @_RNvMNtCs2GUV5EsPSwH_4core3f64d9total_cmpCslvWntd2Wrzg_6probe1(ptr align 8 %self, ptr align 8 %other) unnamed_addr #1 !guid !7 {
start:
  %_6 = alloca [8 x i8], align 8
  %_3 = alloca [8 x i8], align 8
  %_5 = load double, ptr %self, align 8
  %_4 = bitcast double %_5 to i64
  store i64 %_4, ptr %_3, align 8
  %_8 = load double, ptr %other, align 8
  %_7 = bitcast double %_8 to i64
  store i64 %_7, ptr %_6, align 8
  %_13 = load i64, ptr %_3, align 8
  %_12 = ashr i64 %_13, 63
  %_10 = lshr i64 %_12, 1
  %0 = load i64, ptr %_3, align 8
  %1 = xor i64 %0, %_10
  store i64 %1, ptr %_3, align 8
  %_18 = load i64, ptr %_6, align 8
  %_17 = ashr i64 %_18, 63
  %_15 = lshr i64 %_17, 1
  %2 = load i64, ptr %_6, align 8
  %3 = xor i64 %2, %_15
  store i64 %3, ptr %_6, align 8
  %4 = load i64, ptr %_3, align 8
  %5 = load i64, ptr %_6, align 8
  %_0 = call i8 @llvm.scmp.i8.i64(i64 %4, i64 %5)
  ret i8 %_0
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare range(i8 -1, 2) i8 @llvm.scmp.i8.i64(i64, i64) #2

attributes #0 = { nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #1 = { inlinehint nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i64 -5459931197014807244}
!1 = !{i64 1698805204011377915}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 2, !"RtLibUseGOT", i32 1}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!"rustc version 1.101.0-nightly (0abfedbc7 2026-10-02)"}
!6 = !{i64 -7493873156982380430}
!7 = !{i64 5958207931813421499}
