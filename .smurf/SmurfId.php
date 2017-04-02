<?php

namespace Application\Smurf;

class SmurfId
{
    /**
     * @var string
     */
    private $value;

    /**
     * @param string $uuid
     */
    public function __construct($uuid)
    {
        $this->value = $uuid;
    }

    /**
     * @return string
     */
    public function toString()
    {
        return $this->value;
    }
}
