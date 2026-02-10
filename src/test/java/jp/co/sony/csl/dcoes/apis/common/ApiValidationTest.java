package jp.co.sony.csl.dcoes.apis.common;

import org.junit.Test;
import org.junit.runner.RunWith;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.unit.TestContext;
import io.vertx.ext.unit.junit.VertxUnitRunner;

@RunWith(VertxUnitRunner.class)
public class ApiValidationTest {

    @Test public void testRouteAddresses(TestContext ctx) {
        ctx.assertEquals("apis.policy", ServiceAddress.policy());
        ctx.assertEquals("apis.operationMode", ServiceAddress.operationMode());
        ctx.assertEquals("apis.error", ServiceAddress.error());
        ctx.assertEquals("apis.reset.local", ServiceAddress.resetLocal());
        ctx.assertEquals("apis.reset.all", ServiceAddress.resetAll());
        ctx.assertEquals("apis.shutdown.local", ServiceAddress.shutdownLocal());
        ctx.assertEquals("apis.shutdown.all", ServiceAddress.shutdownAll());
        ctx.assertEquals("apis.unit01.helo", ServiceAddress.helo("unit01"));
        ctx.assertEquals("apis.unit01.shutdown", ServiceAddress.shutdown("unit01"));
    }

    @Test public void testControllerRoutes(TestContext ctx) {
        ctx.assertEquals("apis.Controller.data", ServiceAddress.Controller.unitData());
        ctx.assertEquals("apis.Controller.data.urgent", ServiceAddress.Controller.urgentUnitData());
        ctx.assertEquals("apis.Controller.scram", ServiceAddress.Controller.scram());
        ctx.assertEquals("apis.unit01.Controller.data", ServiceAddress.Controller.unitData("unit01"));
    }

    @Test public void testUserRoutes(TestContext ctx) {
        ctx.assertEquals("apis.User.scenario", ServiceAddress.User.scenario());
        ctx.assertEquals("apis.User.mediatorRequest", ServiceAddress.User.mediatorRequest());
        ctx.assertEquals("apis.unit01.operationMode", ServiceAddress.User.operationMode("unit01"));
    }

    @Test public void testDealIdGeneration(TestContext ctx) {
        JsonObject deal = new JsonObject();
        String id = Deal.generateDealId(deal);
        ctx.assertNotNull(id);
        ctx.assertEquals(id, Deal.dealId(deal));
    }

    @Test public void testDealAttributes(TestContext ctx) {
        JsonObject deal = new JsonObject()
            .put("type", "charge").put("requestUnitId", "u1")
            .put("acceptUnitId", "u2").put("dealAmountWh", 50.0f);
        ctx.assertEquals("charge", Deal.type(deal));
        ctx.assertEquals("u1", Deal.requestUnitId(deal));
        ctx.assertEquals("u2", Deal.acceptUnitId(deal));
        ctx.assertNotNull(Deal.dealAmountWh(deal));
    }

    @Test public void testDealDirection(TestContext ctx) {
        ctx.assertEquals(Deal.Direction.CHARGE, Deal.direction("CHARGE"));
        ctx.assertEquals(Deal.Direction.DISCHARGE, Deal.direction("DISCHARGE"));
        ctx.assertNull(Deal.direction("INVALID"));
    }

    @Test public void testErrorEnums(TestContext ctx) {
        ctx.assertEquals(Error.Category.HARDWARE, Error.category("HARDWARE"));
        ctx.assertEquals(Error.Extent.GLOBAL, Error.extent("GLOBAL"));
        ctx.assertEquals(Error.Level.ERROR, Error.level("ERROR"));
        ctx.assertEquals(Error.Category.UNKNOWN, Error.category("INVALID"));
    }

    @Test public void testErrorObject(TestContext ctx) {
        JsonObject err = Error.generateErrorObject("u1", Error.Category.LOGIC,
            Error.Extent.LOCAL, Error.Level.WARN, "test", null);
        ctx.assertEquals("u1", Error.unitId(err));
        ctx.assertEquals(Error.Category.LOGIC, Error.category(err));
        ctx.assertEquals("test", Error.message(err));
    }

    @Test public void testLogMessage(TestContext ctx) {
        String msg = Error.logMessage(Error.Category.HARDWARE, Error.Extent.GLOBAL,
            Error.Level.FATAL, "error msg", "u1", null);
        ctx.assertTrue(msg.contains("HARDWARE"));
        ctx.assertTrue(msg.contains("error msg"));
    }
}

