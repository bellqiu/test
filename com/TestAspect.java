package com.ms.aop.aspect;

import org.apache.commons.lang.time.StopWatch;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class TestAspect {
	
	private static final Logger LOG = LoggerFactory.getLogger(TestAspect.class);

	/*@Around("@annotation(com.ms.fxoption.volserver.aspect.StatisticsPublish) && " +
            "args(..,requestID)")*/
	@Around("@annotation(com.ms.aop.aspect.TestAspectAnnotation)")
	public Object doBasicProfiling(final ProceedingJoinPoint pjp) throws Throwable {
        final StopWatch stopWatch = new StopWatch();
        stopWatch.start();

        try {
            Object result = pjp.proceed();
            return result;
        } finally {
            stopWatch.stop();
            LOG.info("{} took {} ", new Object[]{pjp.toShortString(), stopWatch});
        }
    }
}
