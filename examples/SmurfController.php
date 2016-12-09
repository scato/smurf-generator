<?php

namespace AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

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
