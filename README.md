# smurf-generator
A little blue scaffolding tool

Suppose you have the following example:
```php
/**
 * @Route("/smurf")
 */
class SmurfController extends Controller
{
    /**
     * @Route("/")
     */
    public function defaultAction()
    {
        return new Response(
            '<html><body>SMURF</body></html>'
        );
    }
}
```

And you run:
```bash
./generate.sh src/PaymentProviderController.php
```

Then you end up with:
```php
/**
 * @Route("/paymentProvider")
 */
class PaymentProviderController extends Controller
{
    /**
     * @Route("/")
     */
    public function defaultAction()
    {
        return new Response(
            '<html><body>PAYMENT_PROVIDER</body></html>'
        );
    }
}
```

## Warning
This is just a little experiment. No promises.

