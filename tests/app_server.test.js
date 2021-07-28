app_server = require("../app_server");

test("Testing insert product function", () => {
    var newProduct = {
        productName: "chair",
        productCategory: "Furniture",
        productDescription: "comfortable gaming chair",
        unitPrice: 50,
        initialQuantity: 2,
        remainingQuantity: 1,
        productImageLink: null,
        sellerUsername: "John Wick"
    }

    app_server.insertProduct(newProduct, function (result) {
        expect(result).toBeGreaterThan(-1);
    })

});

test("", () => {
    var address = {
        address_street: "46 college street",
        address_city: "Denton",
        address_state: "TX",
        address_zip: 76201,
    }

    app_server.insertAddress(address, function (result) {
        expect(result).toBeGreaterThan(-1);
    })

});
test("", () => {
    var shippingInfo = {
        shippingToName: "David James",
        shippingAddressId: "12546",
        shippingContactPhone: "9945472364",
    }

    app_server.insertShipping(shippingInfo, function (result) {
        expect(result).toBeGreaterThan(-1);
    })

});


test("", () => {
    var paymentMethod = {
        paymentMethodType:"account",
        accountNumber: "64654346",
        accountOwnerName:"Jerline",
        accountSecurityCode: "425",
        accountExpireDate: "01/10/21",
        billingAddressId:"12",
    }

    app_server.insertPaymentMethod(paymentMethod, function (result) {
        expect(result).toBeGreaterThan(-1);
    })

});

test("", () => {
    var orderInfo = {
        orderDate: "27/07/2021",
        buyerUsername: "Georger",
        paymentMethodId: "10",
        shippingInfoId: "9",
    }

    app_server.insertOrder(orderInfo, function (result) {
        expect(result).toBeGreaterThan(-1);
    })

});
